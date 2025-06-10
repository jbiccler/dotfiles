return {
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            keymaps = {
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-l>"] = false,
            },
            view_options = {
                show_hidden = true,
            },
        },
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = true,
        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = true,
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        prompt_save_on_select_new_entry = true,

        keys = {
            { "<leader>e", ":Oil <cr>",        desc = "Open Oil" },
            { "<leader>E", ":Oil --float<cr>", desc = "Open floating Oil" },
            { "-",         "<CMD>Oil<CR>",     desc = "Open parent directory" },
            { "<BS>",      "<CMD>Oil<CR>",     desc = "Open parent directory" },
            -- { "<leader>ef", ":Oil<cr>", desc = "edit [f]iles" },
        },
        cmd = "Oil",
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.\
        lazy = false,
    },
}
