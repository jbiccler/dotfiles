return {
	{
		"folke/which-key.nvim",
		vscode = true,
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "modern",
			win = {
				no_overlap = false,
			},
		},
	},
}
