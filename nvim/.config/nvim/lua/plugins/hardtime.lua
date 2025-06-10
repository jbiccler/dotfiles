return {
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        enabled = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            max_count = 5,
            disabled_keys = {
                ["<Up>"] = false,
                ["<Down>"] = false,
                ["<Right>"] = false,
                ["<Left>"] = false,
            },
        },
    },
}
