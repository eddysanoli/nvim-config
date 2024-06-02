-- =============================
-- CHANGE TO NORMAL MODE
-- =============================

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})

-- =============================
-- INDENT AND DE-INDENT
-- =============================

-- Normal mode
vim.api.nvim_set_keymap('n', '<Tab>', '>>', {noremap = true}) 
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', {noremap = true})

-- Visual mode
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', {noremap = true})
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', {noremap = true})
