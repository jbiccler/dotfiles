if true then
	return {
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			version = false, -- Never set this value to "*"! Never!
			opts = {
				-- add any opts here
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
				"folke/snacks.nvim", -- for input provider snacks
				"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
				{
					-- Make sure to set this up properly if you have lazy=true
					"MeanderingProgrammer/render-markdown.nvim",
					opts = {
						file_types = { "markdown", "Avante" },
					},
					ft = { "markdown", "Avante" },
				},
			},
		},
	}
end
