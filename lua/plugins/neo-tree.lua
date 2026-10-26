return {
    -- Set up from neo-tree's config below. Its setup hooks into neo-tree's events, so running it
    -- earlier would load neo-tree on every startup. lsp-config.lua only reads its capabilities
    {
        "antosha417/nvim-lsp-file-operations",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "antosha417/nvim-lsp-file-operations",
        },
        cmd = "Neotree",
        keys = {
            { "<C-b>", "<cmd>Neotree filesystem toggle left<CR>", desc = "Open side file tree explorer" },
        },
        init = function()
            -- Load right away when Neovim is opened on a directory, so neo-tree shows it instead of netrw
            if vim.fn.argc(-1) == 1 then
                local stat = vim.uv.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        config = function()
            -- Workaround: lsp-file-operations checks its log file every 30s and errors if it doesn't
            -- exist, but only creates it the first time it logs something. Create it up front
            local lfo_log = vim.fs.joinpath(vim.fn.stdpath("cache"), "lsp-file-operations.log")
            if not vim.uv.fs_stat(lfo_log) then
                vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
                vim.fn.writefile({}, lfo_log)
            end

            require("lsp-file-operations").setup({
                debug = false,

                -- select which file operations to enable
                operations = {
                    willRenameFiles = true,
                    didRenameFiles = true,
                    willCreateFiles = true,
                    didCreateFiles = true,
                    willDeleteFiles = true,
                    didDeleteFiles = true,
                },

                -- how long to wait (in milliseconds) for file rename information before cancelling
                timeout_ms = 10000,
            })

            require("neo-tree").setup({
                source_selector = {
                    winbar = true,
                    statusline = true,
                },
                window = {
                    mappings = {
                        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
                        ["gT"] = "prev_source",
                        ["gt"] = "next_source",
                    },
                },

                -- Close Neo-tree when opening a file
                event_handlers = {
                    {
                        event = "file_open_requested",
                        handler = function()
                            require("neo-tree.command").execute({ action = "close" })
                        end,
                    },
                },

                filesystem = {

                    -- Use libuv to watch for file changes in real time
                    use_libuv_file_watcher = true,

                    -- When neotree is opened, focus on the current file
                    follow_current_file = {
                        enabled = true,
                    },

                    -- Show hidden or ignored files
                    filtered_items = {
                        visible = true,
                    },
                },

                -- Only show active buffers in the buffer source
                buffers = {
                    follow_current_file = {
                        enabled = true,
                    },
                    show_unloaded = false,
                },
            })
        end,
    },
}
