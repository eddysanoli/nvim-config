# Eddysanoli's Neovim Config

This is my personal Neovim configuration. It's a work in progress and its based on the series of videos by [typecraft](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) on YouTube.

The configuration runs on top of Lazy and has LSP Zero for language server support. It also has a few plugins for completion, snippets, as well as other preferences for things like moving around and colorschemes

## Installation 

0. Install Neovim. You can download it from the [official website](https://neovim.io/). If you are on windows, you can install it using [chocolatey](https://chocolatey.org/). Run `choco install neovim` in your terminal.
1. Install a Nerd Font. You can download one from the [official website](https://www.nerdfonts.com/). I use the very basic Jetbrains Mono Nerd Font
2. Clone this repository to your `~/.config/nvim` directory. If you are on windows, you can clone it to `~/AppData/Local/nvim` directory.
3. Open Neovim and run `source %` to source the `init.lua` file. After a second or two, all of the settings should appear on screen
4. Everything should be installed, just try to figure out what to do with the LSP as it depends a bit on the languages that you are going to use 

## Keybindings

- `<leader>` is set to space
- `gd` to go to definition

LSP
- `:Mason` to open the mason menu

Completions
- `<C-j>` and `<C-k>` to navigate through completion items
- `<C-enter>` to confirm completion item
- `<C-e>` to abort
- `<Tab>` to accept a Github Copilot suggestion

Debugging
- `<leader>dt` to toggle a breakpoint
- `<leader>dc` to continue

Git
- `<leader>gp` to preview hunks
- `<leader>gc` to toggle current line blame

Neotree
- `<C-b>` to toggle the file tree

Null-LS
- `<leader>gf` to format code using Null-LS

Sessions 
- `<leader>ls` to see a list of all sessions

Telescope
- `<leader>fg` to look for text in files
- `<C-p>` to find files

Undotree
- `<leader>u` to toggle the undo tree
