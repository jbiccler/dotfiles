return {
    {
      enabled = true,
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante", "codecompanion" },
    },
}
