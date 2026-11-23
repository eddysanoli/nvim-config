# Eddysanoli's Neovim Config

This is my personal Neovim configuration. It's a work in progress and its based on the series of videos by [typecraft](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) on YouTube.

The configuration runs on top of Lazy and has LSP Zero for language server support. It also has a few plugins for completion, snippets, as well as other preferences for things like moving around and colorschemes

## Installation

0. Install Neovim. You can download it from the [official website](https://neovim.io/). If you are on windows, you can install it using [chocolatey](https://chocolatey.org/). Run `choco install neovim` in your terminal.
1. Install a Nerd Font. You can download one from the [official website](https://www.nerdfonts.com/). I use the very basic Jetbrains Mono Nerd Font
2. Clone this repository to your `~/.config/nvim` directory. If you are on windows, you can clone it to `~/AppData/Local/nvim` directory.
3. Open Neovim and run `source %` to source the `init.lua` file. After a second or two, all of the settings should appear on screen
4. Everything should be installed, just try to figure out what to do with the LSP as it depends a bit on the languages that you are going to use

## AI Setup

All AI plugins live in `lua/plugins/ai.lua`. To get them working:

1. Make sure you have a GitHub account with Copilot enabled. The free tier works
2. Install [Node.js](https://nodejs.org/) 22 or newer and make sure `node` is on your PATH (check with `node --version`). Copilot's language server runs on it. On Windows you can run `choco install nodejs-lts`
3. Open Neovim and run `:Copilot auth`. It shows a one-time code and opens GitHub in your browser. Paste the code there and approve the login
4. Check that it worked with `:Copilot status`. Then go into insert mode in any file: suggestions should appear as grey text
5. Open the CodeCompanion chat with `<leader>aa` and send a message. It reuses the login from step 3. If anything fails, run `:checkhealth codecompanion`

### Using Claude in CodeCompanion (optional)

CodeCompanion can also use Claude (Opus 5.5) through the Anthropic API. This needs an API key, which is billed per use and separate from a Claude Pro/Max subscription:

1. Create an API key in the [Anthropic Console](https://console.anthropic.com/)
2. Save it as a user environment variable called `ANTHROPIC_API_KEY`. On Windows, run this in PowerShell: `[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "<your key>", "User")`. Don't put the key in the config, since the config is in git
3. Restart your terminal and Neovim so they pick up the variable

Once the key is set, new chats use Claude by default. Without it, they use Copilot. Inline edits (`<leader>ai`) always use Copilot. You can switch between them in any chat with `ga`.

## Keybindings

Please check the cheatsheet to see all the available keybindings. The keybind for it is `<leader>ch`. Just remember that `<leader>` is set to space by default
