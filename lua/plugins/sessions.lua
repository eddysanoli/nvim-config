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
            auto_restore_last_session = true,

            cwd_change_handling = true,

            -- Allow for the neo-tree to be restored along with the other panes
            auto_clean_after_session_restore = false,

            pre_save_cmds = { "Neotree close" },
            post_restore_cmds = { "Neotree filesystem show" },

            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            session_lens = {
                picker = "telescope",
                bufftypes_to_ignore = {},
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
                mappings = {
                    delete_session = { "n", "d" },
                },
            },
            vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
                noremap = true,
                silent = true,
                desc = "Search saved sessions",
            }),
        })
    end,
}
