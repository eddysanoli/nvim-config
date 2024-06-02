-- Download Lazy.vim if it doesn't exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================
-- ADDITIONAL REQUIRES 
-- =============================

require("vim-options")
require("keymaps")

-- =============================
-- ENABLE LAZY
-- =============================

require("lazy").setup("plugins")

