return {
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		vscode = true,
		opts = function()
			local ai = require("mini.ai")
			return {
				mappings = {
					around_last = "",
					inside_last = "",
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			LazyVim.on_load("which-key.nvim", function()
				vim.schedule(function()
					LazyVim.mini.ai_whichkey(opts)
				end)
			end)
		end,
	},
}
