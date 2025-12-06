return {
	{
		"yetone/avante.nvim",
		enabled = false,
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			behaviour = {
				use_cwd_as_project_root = true,
			},
			-- for example
			provider = "gemini",
			providers = {
				gemini = {
					model = "gemini-2.0-flash",
				},
			},
		},
		input = {
			provider = "snacks", -- "native" | "dressing" | "snacks"
			provider_opts = {
				-- Snacks input configuration
				title = "Avante Input",
				icon = " ",
				placeholder = "Enter your API key...",
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- "saghen/blink.cmp",
			--- The below dependencies are optional,
			"folke/snacks.nvim", -- for input provider snacks
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"MeanderingProgrammer/render-markdown.nvim",
		},
	},
}
