return {
	{
		"olimorris/codecompanion.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		opts = {
			strategies = {
				chat = {
					adapter = "gemini",
					model = "gemini-2.5-flash-preview",
					keymaps = {
						send = {
							modes = { n = "<leader>as", i = "<leader>as" },
							opts = {},
						},
						close = {
							modes = {
								n = "q",
							},
							index = 3,
							callback = "keymaps.close",
							description = "Close Chat",
						},
						stop = {
							modes = {
								n = "<esc>",
							},
							index = 4,
							callback = "keymaps.stop",
							description = "Stop Request",
						},
					},
				},
				inline = {
					adapter = "gemini",
					model = "gemini-2.5-flash-preview",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the suggested change",
						},
						reject_change = {
							modes = { n = "gr" },
							description = "Reject the suggested change",
						},
					},
				},
				cmd = { adapter = "gemini", model = "gemini-2.5-flash-preview" },
			},
			adapters = {},
		},
		keys = {
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				noremap = true,
				silent = true,
				desc = "CodeCompanion chat toggle",
			},
			{
				"<leader>aa",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				noremap = true,
				silent = true,
				desc = "CodeCompanion add to chat",
			},
		},
		config = function(_, opts)
			opts.adapters.gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = vim.env.GEMINI_API_KEY,
					},
					scheme = {
						model = {
							default = "gemini-2.5-flash-preview",
						},
					},
				})
			end
			require("codecompanion").setup(opts)
		end,
	},
	{
		"nvim-mini/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},
}
