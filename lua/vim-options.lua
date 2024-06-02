vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.o.readonly = false

-- Enable line numbers with relative numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- Make the clipboard the recepient of all yanked data
vim.o.clipboard = "unnamedplus"

