-- banner.nvim: turn a line of text into a comment banner, and back.
--
-- Block (<leader>cb):                               Single line (<leader>cl):
--   # ============================================== #   # =================== REGION =================== #
--   # SETUP DASHBOARD                                #
--   # ============================================== #
--
-- Behaviour:
--   * Side markers come from the comment string at the cursor (treesitter aware), so Lua gets
--     "-- ... --", JS "// ... //", HTML "<!-- ... -->". Without one, `fallback_marker` is used.
--   * `width` is the whole banner, markers included, counted from the line's indentation.
--     Text that doesn't fit is cut short and ends with `ellipsis`.
--   * Pressing a mapping on a banner of the same kind removes it (the text stays uppercased).
--     Pressing it on a banner of the other kind converts it.
--   * Visual block: all selected lines become rows of one box. Visual line: each line becomes
--     its own banner (or stops being one). Blank lines are skipped.
--   * A leading comment marker on plain text is dropped ("# setup" -> "SETUP").
--   * Every change is one undo step, and normal-mode presses repeat with `.`.

local M = {}

local defaults = {
	fill = "=", -- character the rules are drawn with (must be one display column wide)
	width = 50, -- total banner width, markers included, counted from the indentation
	uppercase = true, -- uppercase the text when a banner is made
	min_fill = 3, -- shortest run of fill on each side of the text in a single-line banner
	ellipsis = "…", -- ends text that was cut short to fit the width
	fallback_marker = "#", -- side marker when the buffer has no comment string
}

M.config = vim.deepcopy(defaults)

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

local dw = vim.fn.strdisplaywidth

local function warn(msg)
	vim.notify("banner: " .. msg, vim.log.levels.WARN)
end

-- ============================ MARKERS ============================

-- Left and right markers from the comment string at the cursor ("# %s" -> "#", "#")
local function markers()
	local cs
	local ok, tscs = pcall(require, "ts_context_commentstring")
	if ok then
		local ok_calc, res = pcall(tscs.calculate_commentstring)
		if ok_calc and type(res) == "string" then
			cs = res
		end
	end
	if not cs or cs == "" then
		cs = vim.bo.commentstring
	end
	local l, r = (cs or ""):match("^(.-)%%s(.-)$")
	l, r = vim.trim(l or ""), vim.trim(r or "")
	if l == "" then
		l = M.config.fallback_marker
		r = l
	elseif r == "" then
		r = l
	end
	return l, r
end

-- ============================ BUILDING ============================

local function fill_run(cols)
	return string.rep(M.config.fill, math.floor(cols / dw(M.config.fill)))
end

-- Cut text to at most `max` display columns, ending it with the ellipsis when cut
local function truncate(text, max)
	if dw(text) <= max then
		return text
	end
	local out, used = {}, dw(M.config.ellipsis)
	for _, ch in ipairs(vim.fn.split(text, "\\zs")) do
		used = used + dw(ch)
		if used > max then
			break
		end
		table.insert(out, ch)
	end
	return table.concat(out):gsub("%s+$", "") .. M.config.ellipsis
end

local function upper(text)
	return M.config.uppercase and vim.fn.toupper(text) or text
end

local function block_lines(indent, l, r, texts)
	local area = M.config.width - dw(l) - dw(r) - 2 -- one space after l, one before r
	local rule = indent .. l .. " " .. fill_run(area) .. " " .. r
	local out = { rule }
	for _, text in ipairs(texts) do
		text = truncate(text, area)
		table.insert(out, indent .. l .. " " .. text .. string.rep(" ", area - dw(text)) .. " " .. r)
	end
	table.insert(out, rule)
	return out
end

local function single_line(indent, l, r, text)
	local spare = M.config.width - dw(l) - dw(r) - 4 -- spaces: after l, around text, before r
	text = truncate(text, spare - 2 * M.config.min_fill)
	local leftover = spare - dw(text)
	local left = math.floor(leftover / 2) -- an odd column goes to the right side
	return indent .. l .. " " .. fill_run(left) .. " " .. text .. " " .. fill_run(leftover - left) .. " " .. r
end

-- ============================ PARSING ============================

local function split_indent(line)
	return line:match("^(%s*)(.*)$")
end

-- "l <inner> r" -> inner, or nil when the line isn't wrapped in the markers
local function inner_of(rest, l, r)
	if #rest < #l + #r + 2 or rest:sub(1, #l) ~= l or rest:sub(-#r) ~= r then
		return nil
	end
	local inner = rest:sub(#l + 1, #rest - #r)
	if inner:sub(1, 1) ~= " " or inner:sub(-1) ~= " " then
		return nil
	end
	return inner:sub(2, -2)
end

-- Remove repeated fill from the start (or end) of s. Returns what's left and how many were removed
local function strip_fill(s, from_end)
	local f, n = M.config.fill, 0
	if from_end then
		while #s >= #f and s:sub(-#f) == f do
			s, n = s:sub(1, -#f - 1), n + 1
		end
	else
		while #s >= #f and s:sub(1, #f) == f do
			s, n = s:sub(#f + 1), n + 1
		end
	end
	return s, n
end

-- What a line is: a rule ("# ===== #"), a single-line banner ("# == TEXT == #"), a text row
-- ("# TEXT    #", only a banner part when between rules), or nil (anything else)
local function classify(line, l, r)
	local indent, rest = split_indent(line)
	local inner = inner_of(rest, l, r)
	if not inner then
		return nil
	end
	local raw = vim.trim(inner)
	local after, n_left = strip_fill(inner, false)
	if n_left > 0 and after == "" then
		return { kind = "rule", indent = indent }
	end
	if n_left > 0 and after:sub(1, 1) == " " then
		local mid, n_right = strip_fill(after, true)
		if n_right > 0 and mid:sub(-1) == " " and vim.trim(mid) ~= "" then
			return { kind = "single", indent = indent, text = vim.trim(mid), raw = raw }
		end
	end
	return { kind = "text", indent = indent, raw = raw }
end

-- The block banner containing line lnum: { s, e, indent, texts }, or nil
local function find_block(lnum, l, r)
	local total = vim.api.nvim_buf_line_count(0)
	local cache = {}
	local function get(n)
		if n < 1 or n > total then
			return nil
		end
		if cache[n] == nil then
			cache[n] = classify(vim.api.nvim_buf_get_lines(0, n - 1, n, false)[1], l, r) or false
		end
		return cache[n] or nil
	end

	-- Block whose top rule is at line `top`
	local function block_from(top)
		local head = get(top)
		if not head or head.kind ~= "rule" then
			return nil
		end
		local texts, n = {}, top + 1
		while true do
			local c = get(n)
			if not c or c.indent ~= head.indent then
				return nil
			end
			if c.kind == "rule" then
				return #texts > 0 and { s = top, e = n, indent = head.indent, texts = texts } or nil
			end
			table.insert(texts, c.raw)
			n = n + 1
		end
	end

	-- First rule at or above n, passing only banner-shaped lines
	local function rule_above(n)
		while true do
			local c = get(n)
			if not c then
				return nil
			end
			if c.kind == "rule" then
				return n
			end
			n = n - 1
		end
	end

	local here = get(lnum)
	if not here then
		return nil
	end
	if here.kind == "rule" then
		-- Top rule of a block, or else its bottom rule
		local block = block_from(lnum)
		if block then
			return block
		end
		local top = rule_above(lnum - 1)
		block = top and block_from(top)
		return block and block.e == lnum and block or nil
	end
	local top = rule_above(lnum)
	local block = top and block_from(top)
	return block and block.e >= lnum and block or nil
end

-- Banner text from a line that isn't a banner. Drops a leading comment marker
local function plain_text(line, l, r)
	local c = classify(line, l, r)
	if c and c.kind == "text" then
		return upper(c.raw) -- "# text #" outside a block
	end
	local t = vim.trim(line)
	if t:sub(1, #l) == l and (#t == #l or t:sub(#l + 1, #l + 1) == " ") then
		t = vim.trim(t:sub(#l + 1))
		if r ~= l and t:sub(-#r) == r then
			t = vim.trim(t:sub(1, -#r - 1))
		end
	end
	return upper(t)
end

-- ============================ ACTIONS ============================

local function width_ok(l, r)
	local need = dw(l) + dw(r) + 4 + 2 * M.config.min_fill + dw(M.config.ellipsis) + 1
	if M.config.width < need then
		warn(("width %d is too small for markers %q %q (need at least %d)"):format(M.config.width, l, r, need))
		return false
	end
	return true
end

-- Make, convert or remove a banner of `kind` ("block" or "line") on lines s..e (1-based)
function M.apply(kind, s, e)
	local l, r = markers()
	if not width_ok(l, r) then
		return
	end
	local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
	local block = find_block(s, l, r)

	if kind == "block" then
		if block then -- remove it
			local out = {}
			for _, t in ipairs(block.texts) do
				table.insert(out, t == "" and "" or block.indent .. t)
			end
			vim.api.nvim_buf_set_lines(0, block.s - 1, block.e, false, out)
			return
		end
		local texts, indent = {}, nil
		for _, line in ipairs(lines) do
			local ind, rest = split_indent(line)
			local c = classify(line, l, r)
			if rest ~= "" and not (c and c.kind == "rule") then
				indent = indent or ind
				table.insert(texts, c and c.kind == "single" and c.text or plain_text(line, l, r))
			end
		end
		if #texts == 0 then
			return warn("no text to put in a banner")
		end
		vim.api.nvim_buf_set_lines(0, s - 1, e, false, block_lines(indent, l, r, texts))
		return
	end

	if block then -- convert to single-line banners
		local out = {}
		for _, t in ipairs(block.texts) do
			if t ~= "" then
				table.insert(out, single_line(block.indent, l, r, t))
			end
		end
		vim.api.nvim_buf_set_lines(0, block.s - 1, block.e, false, out)
		return
	end
	local out, changed = {}, false
	for _, line in ipairs(lines) do
		local ind, rest = split_indent(line)
		local c = classify(line, l, r)
		if rest == "" or (c and c.kind == "rule") then
			table.insert(out, line)
		elseif c and c.kind == "single" then -- remove it
			table.insert(out, ind .. c.text)
			changed = true
		else
			table.insert(out, single_line(ind, l, r, plain_text(line, l, r)))
			changed = true
		end
	end
	if not changed then
		return warn("no text to put in a banner")
	end
	vim.api.nvim_buf_set_lines(0, s - 1, e, false, out)
end

-- ============================ MAPPINGS ============================

-- Normal mode, as an operator on the current line so `.` repeats it. Use in an expr mapping
function M.operator(kind)
	vim.go.operatorfunc = "v:lua.require'banner'.opfunc_" .. kind
	return "g@l"
end

function M.opfunc_block()
	local n = vim.fn.line("'[")
	M.apply("block", n, n)
end

function M.opfunc_line()
	local n = vim.fn.line("'[")
	M.apply("line", n, n)
end

-- Visual mode, on the selected lines
function M.visual(kind)
	local s, e = vim.fn.line("v"), vim.fn.line(".")
	if s > e then
		s, e = e, s
	end
	vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
	M.apply(kind, s, e)
end

return M
