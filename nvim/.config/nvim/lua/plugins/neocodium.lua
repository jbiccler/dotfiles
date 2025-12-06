return {
	"monkoose/neocodeium",
	enabled = false,
	event = "VeryLazy",
	config = function()
		local filetypes = { "lua", "python", "rust", "c", "cpp", "md", "go" }
		local neocodeium = require("neocodeium")
		neocodeium.setup({
			-- function accepts one argument `bufnr`
			-- Only use in certain filetypes
			filter = function(bufnr)
				if vim.tbl_contains(filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr })) then
					return true
				end
				return false
			end,
		})
		-- vim.keymap.set("i", "<Tab>", neocodeium.accept)
		vim.keymap.set("i", "<A-f>", neocodeium.accept)
	end,
}
