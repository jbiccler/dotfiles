return {
	"epwalsh/obsidian.nvim",
	enabled = false,
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "vault",
				path = "/mnt/d/JDN/Notes/Obsidian-Vault",
			},
		},
		-- see below for full list of options 👇
		notes_subdir = "notes",
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "notes",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y%m%d",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "Daily.md",
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>oc"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		-- Optional, for templates (see below).
		templates = {
			folder = "Templates",
			date_format = "%d-%m-%Y",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},
	},
	keys = {
		{ "<Leader>oc", "<Cmd>ObsidianToggleCheckbox<CR>", desc = "Toggle check box" },
		{ "<Leader>odd", "<Cmd>ObsidianDailies<CR>", desc = "Open daily notes" },
		{ "<Leader>odt", "<Cmd>ObsidianToday<CR>", desc = "Open today's note" },
		{ "<Leader>odm", "<Cmd>ObsidianTomorrow<CR>", desc = "Open tomorrow's note" },
		{ "<Leader>ody", "<Cmd>ObsidianYesterday<CR>", desc = "Open yesterday's note" },
		{ "<Leader>of", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch notes" },
		{ "<Leader>os", "<Cmd>ObsidianSearch<CR>", desc = "Search in notes" },
		{ "<Leader>on", "<Cmd>ObsidianNew<CR>", desc = "Create a new note" },
		{ "<Leader>ot", "<Cmd>ObsidianNewFromTemplate<CR>", desc = "New from template" },
		{ "<Leader>op", "<Cmd>ObsidianPasteImg<CR>", desc = "Paste image" },
		{ "<Leader>or", "<Cmd>ObsidianRename<CR>", desc = "Rename note" },
	},
}
