-- packer.nvim config
-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end
-- configure plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "<space><space>s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<space><space><M-s>", ":HopPattern<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<space><space>S", ":HopWord<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "f", ":HopChar1AC<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "F", ":HopChar1BC<cr>", { silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"t",
				":lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR,hint_offset = -1})<cr>",
				{ silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"T",
				":lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR,hint_offset = 1})<cr>",
				{ silent = true }
			)
		end,
	})

	-- surround text objects
	use({
		"echasnovski/mini.surround",
		branch = "stable",
		-- config = function()
		--     require("mini.surround").setup({
		--         mappings = {
		--             add = "gsa",
		--             delete = "gsd",
		--             find = "gsf",
		--             find_left = "gsF",
		--             highlight = "gsh",
		--             replace = "gsr",
		--             update_n_lines = "gsn",
		--         },
		--     })
		-- end,
	})
	-- comment/uncomment
	use({ "echasnovski/mini.comment", branch = "stable" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
