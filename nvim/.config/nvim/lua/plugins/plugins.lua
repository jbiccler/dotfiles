if true then
	return {
		{
			"vigemus/iron.nvim",
			event = "VeryLazy",
			opts = function()
				return {
					config = {
						-- Whether a repl should be discarded or not
						scratch_repl = true,
						-- Your repl definitions come here
						repl_definition = {
							python = require("iron.fts.python").python,
							sh = {
								command = { "fish" },
							},
						},
						repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
						ignore_blank_lines = true,
					},
				}
			end,
      -- stylua: ignore
      keys = {
        { "<leader>r", function() end, mode = {"n", "x"}, desc = "+REPL" },
        { "<leader>rm", function() end, mode = {"n", "x"}, desc = "+Mark" },
        { "<leader>rs", function() require("iron.core").run_motion("send_motion") end, desc = "Send Motion" },
        { "<leader>rs", function() require("iron.core").visual_send() end, mode = {"v"}, desc = "Send" },
        { "<leader>rl", function() require("iron.core").send_line() end, desc = "Send Line" },
        { "<leader>rt", function() require("iron.core").send_until_cursor() end, desc = "Send Until Cursor" },
        { "<leader>rf", function() require("iron.core").send_file() end, desc = "Send File" },
        { "<leader>r<cr>", function() require("iron.core").send(nil, string.char(13)) end, desc = "ENTER" },
        { "<leader>rI", function() require("iron.core").send(nil, string.char(03)) end, desc = "Interrupt" },
        { "<leader>rC", function() require("iron.core").close_repl() end, desc = "Close REPL" },
        { "<leader>rc", function() require("iron.core").send(nil, string.char(12)) end, desc = "Clear" },
        { "<leader>rms", function() require("iron.core").send_mark() end, desc = "Send Mark" },
        { "<leader>rmm", function() require("iron.core").run_motion("mark_motion") end, desc = "Mark Motion" },
        { "<leader>rmv", function() require("iron.core").mark_visual() end, mode = {"v"}, desc = "Mark Visual" },
        { "<leader>rmr", function() require("iron.marks").drop_last() end, desc = "Remove Mark" },
        { "<leader>rR", "<cmd>IronRepl<cr>", desc = "REPL" },
        { "<leader>rS", "<cmd>IronRestart<cr>", desc = "Restart" },
        { "<leader>rF", "<cmd>IronFocus<cr>", desc = "Focus" },
        { "<leader>rH", "<cmd>IronHide<cr>", desc = "Hide" },
      },
			config = function(_, opts)
				local iron = require("iron.core")
				iron.setup(opts)
			end,
		},
		{
			"folke/tokyonight.nvim",
			opts = {
				style = "storm",
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			},
		},

		-- change trouble config
		{
			"folke/trouble.nvim",
			-- opts will be merged with the parent spec
			opts = { use_diagnostic_signs = true },
		},

		-- add symbols-outline
		{
			"simrat39/symbols-outline.nvim",
			cmd = "SymbolsOutline",
			keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
			config = true,
		},

		-- add more treesitter parsers
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"cpp",
					"go",
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

							["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
							["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
							["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
							["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
							["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

							["am"] = {
								query = "@function.outer",
								desc = "Select outer part of a method/function definition",
							},
							["im"] = {
								query = "@function.inner",
								desc = "Select inner part of a method/function definition",
							},

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

							["at"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
							["<leader>n:"] = "@property.outer", -- swap object property with next
							["<leader>nm"] = "@function.outer", -- swap function with next
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
							["<leader>p:"] = "@property.outer", -- swap object property with prev
							["<leader>pm"] = "@function.outer", -- swap function with previous
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = { query = "@call.outer", desc = "Next function call start" },
							["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
							["]c"] = { query = "@class.outer", desc = "Next class start" },
							["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
							["]l"] = { query = "@loop.outer", desc = "Next loop start" },

							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = { query = "@call.outer", desc = "Next function call end" },
							["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
							["]C"] = { query = "@class.outer", desc = "Next class end" },
							["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
							["]L"] = { query = "@loop.outer", desc = "Next loop end" },
						},
						goto_previous_start = {
							["[f"] = { query = "@call.outer", desc = "Prev function call start" },
							["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
							["[c"] = { query = "@class.outer", desc = "Prev class start" },
							["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
							["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
						},
						goto_previous_end = {
							["[F"] = { query = "@call.outer", desc = "Prev function call end" },
							["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
							["[C"] = { query = "@class.outer", desc = "Prev class end" },
							["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
							["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
						},
					},
				},
			},
		},

		-- Add default installed options to Mason
		{
			"mason-org/mason.nvim",
			opts = {
				ensure_installed = {
					"shellcheck",
					"shfmt",
					"stylua",
					"flake8",
					"pyright",
					"ruff",
					"rust-analyzer",
					"clangd",
					"codelldb",
					"taplo",
				},
			},
		},
		{
			"aserowy/tmux.nvim",
			config = function()
				return require("tmux").setup()
			end,
			opts = {
				copy_sync = {
					-- enables copy sync. by default, all registers are synchronized.
					-- to control which registers are synced, see the `sync_*` options.
					enable = true,
					-- ignore specific tmux buffers e.g. buffer0 = true to ignore the
					-- first buffer or named_buffer_name = true to ignore a named tmux
					-- buffer with name named_buffer_name :)
					ignore_buffers = { empty = false },
					-- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
					-- clipboard by tmux
					redirect_to_clipboard = false,
					-- offset controls where register sync starts
					-- e.g. offset 2 lets registers 0 and 1 untouched
					register_offset = 0,
					-- overwrites vim.g.clipboard to redirect * and + to the system
					-- clipboard using tmux. If you sync your system clipboard without tmux,
					-- disable this option!
					sync_clipboard = true,
					-- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
					sync_registers = true,
					-- syncs deletes with tmux clipboard as well, it is adviced to
					-- do so. Nvim does not allow syncing registers 0 and 1 without
					-- overwriting the unnamed register. Thus, ddp would not be possible.
					sync_deletes = true,
					-- syncs the unnamed register with the first buffer entry from tmux.
					sync_unnamed = true,
				},
				navigation = {
					-- cycles to opposite pane while navigating into the border
					cycle_navigation = true,
					-- enables default keybindings (C-hjkl) for normal mode
					enable_default_keybindings = true,
					-- prevents unzoom tmux when navigating beyond vim border
					persist_zoom = false,
				},
				resize = {
					-- enables default keybindings (A-hjkl) for normal mode
					enable_default_keybindings = false,
					-- sets resize steps for x axis
					resize_step_x = 1,
					-- sets resize steps for y axis
					resize_step_y = 1,
				},
			},
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = {
				window = {
					position = "left",
					width = 25,
				},
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = true,
						hide_gitignored = true,
					},
				},
			},
		},
		{
			"m4xshen/hardtime.nvim",
			lazy = false,
			dependencies = { "MunifTanjim/nui.nvim" },
			opts = {},
		},
		-- Set which-key layout
		{
			"folke/which-key.nvim",
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
end
