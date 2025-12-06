return {
	{
		"saghen/blink.cmp",
		-- opts = {
		-- 	keymap = {
		-- 	    ["<S-Tab>"] = { "select_prev", "fallback" },
		-- 	    ["<Tab>"] = { "select_next", "fallback" },
		-- 	},
		-- },
		dependencies = {
			{
				-- "giuxtaposition/blink-cmp-copilot",
				-- "Exafunction/windsurf.nvim",
				-- "monkoose/neocodeium",
			},
		},
		opts = {
			keymap = {
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					-- "copilot",
					-- "codeium",
					-- "neocodeium",
				},
				providers = {
					-- copilot = {
					-- 	name = "copilot",
					-- 	module = "blink-cmp-copilot",
					-- 	score_offset = 100,
					-- 	async = true,
					-- 	transform_items = function(_, items)
					-- 		local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					-- 		local kind_idx = #CompletionItemKind + 1
					-- 		CompletionItemKind[kind_idx] = "Copilot"
					-- 		for _, item in ipairs(items) do
					-- 			item.kind = kind_idx
					-- 		end
					-- 		return items
					-- 	end,
					-- },
					-- codeium = { name = "Codeium", module = "codeium.blink", async = true },
					-- neocodeium = { name = "Neocodeium", async = true },
				},
			},
			appearance = {
				kind_icons = {
					-- Copilot = "",
					-- Codeium = "",
					Neocodeium = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},
		},
	},
}
