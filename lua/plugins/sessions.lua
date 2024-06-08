return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({

            -- Allow for the neo-tree to be restored along with the other panes
            auto_clean_after_session_restore = false,
            pre_save_cmds = { "Neotree close" },
            post_restore_cmds = { "Neotree filesystem show" },

            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            session_lens = {
                bufftypes_to_ignore = {},
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },
            vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
                noremap = true,
                silent = true,
                desc = "Search saved sessions",
            }),
        })
    end,
}
