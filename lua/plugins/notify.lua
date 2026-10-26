return {
    'rcarriga/nvim-notify',
    lazy = true,
    -- Load the plugin the first time something sends a notification
    init = function()
        vim.notify = function(...)
            return require('notify')(...)
        end
    end,
    config = function()
        require('notify').setup({
            stages = "fade_in_slide_out",
            background_colour = "#000000",
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.8)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.8)
            end,
            -- Notification windows are focusable by default, so window commands can move the cursor
            -- into them. Restoring a session does that: its "wincmd w" steps land in any notification
            -- shown during startup. Unfocusable windows are skipped (history: <leader>fn)
            on_open = function(win)
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end
            end,
        })

        vim.notify = require('notify')
    end,
}
