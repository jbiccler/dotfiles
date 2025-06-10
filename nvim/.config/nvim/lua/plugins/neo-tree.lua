return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
        opts = {
            window = {
                position = "left",
                width = 25,
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                },
            },
        },
    },
}
