return {
    "rmagatti/auto-session",
    -- keys = {
    --     { "<leader>ls", "<cmd>AutoSession search<CR>", desc = "Session search" },
    -- },
    config = function()
        require("auto-session").setup({
            enabled = true,
            auto_save = true,
            auto_restore = true,
            auto_create = true,
            show_auto_restore_notif = true,
            -- Only when started without arguments. auto-session doesn't check this itself, so
            -- `nvim some_file` would otherwise open the last session instead of that file
            auto_restore_last_session = vim.fn.argc(-1) == 0,

            cwd_change_handling = true,

            -- Allow for the neo-tree to be restored along with the other panes
            auto_clean_after_session_restore = false,

            -- Only close the tree if neo-tree is loaded, so saving on exit doesn't load it
            pre_save_cmds = {
                function()
                    if package.loaded["neo-tree"] then
                        vim.cmd("Neotree close")
                    end
                end,
            },
            post_restore_cmds = { "Neotree filesystem show" },

            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            session_lens = {
                picker = "telescope",
                bufftypes_to_ignore = {},
                -- Telescope is loaded when the session list is opened instead of at startup
                load_on_setup = false,
                picker_opts = { border = true },
                previewer = false,
                mappings = {
                    delete_session = { "n", "d" },
                },
            },
        })

        vim.keymap.set("n", "<leader>ls", function()
            require("auto-session.session-lens").search_session()
        end, {
            noremap = true,
            silent = true,
            desc = "Search saved sessions",
        })
    end,
}
