return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            local make_finder = function()
                local paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(paths, item.value)
                end
                return require("telescope.finders").new_table({
                    results = paths,
                })
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_buffer_number, map)
                        map("n", "d", function()
                            local state = require("telescope.actions.state")
                            local selected_entry = state.get_selected_entry()
                            local current_picker = state.get_current_picker(prompt_buffer_number)
                            harpoon:list():remove(selected_entry)
                            current_picker:refresh(make_finder())
                        end)

                        return true
                    end,
                })
                :find()
        end

        -- Keybindings
        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Add current window to harpoon list" })
        vim.keymap.set("n", "<leader>hl", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })
        vim.keymap.set("n", "<leader>h1", function()
            harpoon:list():select(1)
        end, { desc = "Select harpoon window 1" })
        vim.keymap.set("n", "<leader>h2", function()
            harpoon:list():select(2)
        end, { desc = "Select harpoon window 2" })
        vim.keymap.set("n", "<leader>h3", function()
            harpoon:list():select(3)
        end, { desc = "Select harpoon window 3" })
        vim.keymap.set("n", "<leader>h4", function()
            harpoon:list():select(4)
        end, { desc = "Select harpoon window 4" })
        vim.keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
        end, { desc = "Select previous harpoon window" })
        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
        end, { desc = "Select next harpoon window" })
    end,
}
