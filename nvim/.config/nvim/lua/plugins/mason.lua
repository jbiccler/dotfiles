return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "shellcheck",
                "shfmt",
                "stylua",
                "flake8",
                "pyright",
                "ruff",
                "rust-analyzer",
                "clangd",
                "codelldb",
                "taplo",
            },
        },
    },
}
