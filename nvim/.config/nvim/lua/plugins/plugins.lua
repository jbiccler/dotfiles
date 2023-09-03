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

		-- change some telescope options and a keymap to browse plugin files
		{
			"nvim-telescope/telescope.nvim",
			keys = {
        -- stylua: ignore
          -- disable the keymap to grep files
          { "<leader><space>", false },
				-- add a keymap to browse plugin files
				{
					"<leader>fp",
					function()
						require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
					end,
					desc = "Find Plugin File",
				},
			},
		},

		-- add telescope-fzf-native
		{
			"telescope.nvim",
			dependencies = {
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},

		-- add pyright to lspconfig
		{
			"neovim/nvim-lspconfig",
			---@class PluginLspOpts
			opts = {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = { spacing = 4, prefix = "●" },
					severity_sort = true,
				},
				-- Automatically format on save
				autoformat = true,
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				---@type lspconfig.options
				servers = {
					-- pyright will be automatically installed with mason and loaded with lspconfig
					pyright = {},
					lua_ls = {},
					rust_analyzer = {
						keys = {
							{ "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
							{ "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
							{ "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
						},
						settings = {
							["rust-analyzer"] = {
								cargo = {
									allFeatures = true,
									loadOutDirsFromCheck = true,
									runBuildScripts = true,
								},
								-- Add clippy lints for Rust.
								checkOnSave = {
									allFeatures = true,
									command = "clippy",
									extraArgs = { "--no-deps" },
								},
								procMacro = {
									enable = true,
									ignored = {
										["async-trait"] = { "async_trait" },
										["napi-derive"] = { "napi" },
										["async-recursion"] = { "async_recursion" },
									},
								},
							},
						},
					},
					taplo = {
						keys = {
							{
								"K",
								function()
									if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
										require("crates").show_popup()
									else
										vim.lsp.buf.hover()
									end
								end,
								desc = "Show Crate Documentation",
							},
						},
					},
					neocmake = {},
					clangd = {
						keys = {
							{
								"<leader>cR",
								"<cmd>ClangdSwitchSourceHeader<cr>",
								desc = "Switch Source/Header (C/C++)",
							},
						},
						root_dir = function(fname)
							return require("lspconfig.util").root_pattern(
								"Makefile",
								"configure.ac",
								"configure.in",
								"config.h.in",
								"meson.build",
								"meson_options.txt",
								"build.ninja"
							)(fname) or require("lspconfig.util").root_pattern(
								"compile_commands.json",
								"compile_flags.txt"
							)(fname) or require("lspconfig.util").find_git_ancestor(fname)
						end,
						capabilities = {
							offsetEncoding = { "utf-16" },
						},
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--header-insertion=iwyu",
							"--completion-style=detailed",
							"--function-arg-placeholders",
							"--fallback-style=llvm",
						},
						init_options = {
							usePlaceholders = true,
							completeUnimported = true,
							clangdFileStatus = true,
						},
					},
					tailwindcss = {
						filetypes_exclude = { "markdown" },
					},
				},
				setup = {
					rust_analyzer = function(_, opts)
						local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
						require("rust-tools").setup(
							vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts })
						)
						return true
					end,
					clangd = function(_, opts)
						local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
						require("clangd_extensions").setup(
							vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
						)
						return false
					end,
					tailwindcss = function(_, opts)
						local tw = require("lspconfig.server_configurations.tailwindcss")
						--- @param ft string
						opts.filetypes = vim.tbl_filter(function(ft)
							return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
						end, tw.default_config.filetypes)
					end,
				},
			},
		},

		-- add more treesitter parsers
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"bash",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"rust",
					"toml",
					"ron",
					"cpp",
					"go",
				},
			},
		},

		-- use mini.starter instead of alpha
		{ import = "lazyvim.plugins.extras.ui.mini-starter" },

		-- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
		{ import = "lazyvim.plugins.extras.lang.json" },

		-- add any tools you want to have installed below
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"stylua",
					"shellcheck",
					"shfmt",
					"flake8",
					"pyright",
					"black",
					"rust-analyzer",
					"rustfmt",
					"codelldb",
					"flake8",
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
			"phaazon/hop.nvim",
			event = "BufRead",
			config = function()
				require("hop").setup()
				vim.api.nvim_set_keymap("n", "<leader><leader>s", ":HopChar2<cr>", { silent = true })
				vim.api.nvim_set_keymap("n", "<leader><leader><M-s>", ":HopPattern<cr>", { silent = true })
				vim.api.nvim_set_keymap("n", "<leader><leader>S", ":HopWord<cr>", { silent = true })
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
		},
		-- {
		--   "rmagatti/auto-session",
		--   opts = {
		--     log_level = "error",
		--     auto_session_supress_dirs = { "~/", "~/Downloads" },
		--   },
		-- },
		{
			"iamcco/markdown-preview.nvim",
			ft = "markdown",
			-- build = "cd app && yarn install",
			build = ":call mkdp#util#install()",
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			dependencies = {
				{
					"nvim-treesitter/nvim-treesitter",
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
		-- Rust specific tooling
		{
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			config = true,
		},
		{
			"simrat39/rust-tools.nvim",
			lazy = true,
			opts = function()
				local ok, mason_registry = pcall(require, "mason-registry")
				local adapter ---@type any
				if ok then
					-- rust tools configuration for debugging support
					local codelldb = mason_registry.get_package("codelldb")
					local extension_path = codelldb:get_install_path() .. "/extension/"
					local codelldb_path = extension_path .. "adapter/codelldb"
					local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
						or extension_path .. "lldb/lib/liblldb.so"
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
				end
				return {
					dap = {
						adapter = adapter,
					},
					tools = {
						on_initialized = function()
							vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
						end,
					},
				}
			end,
			config = function() end,
		},
		-- Cpp specific stuff
		{
			"p00f/clangd_extensions.nvim",
			lazy = true,
			config = function() end,
			opts = {
				inlay_hints = {
					inline = true,
				},
				ast = {
					--These require codicons (https://github.com/microsoft/vscode-codicons)
					role_icons = {
						type = "",
						declaration = "",
						expression = "",
						specifier = "",
						statement = "",
						["template argument"] = "",
					},
					kind_icons = {
						Compound = "",
						Recovery = "",
						TranslationUnit = "",
						PackExpansion = "",
						TemplateTypeParm = "",
						TemplateTemplateParm = "",
						TemplateParamObject = "",
					},
				},
			},
		},
		{
			"mfussenegger/nvim-dap",
			optional = true,
			dependencies = {
				-- Ensure C/C++ debugger is installed
				"williamboman/mason.nvim",
				optional = true,
				opts = function(_, opts)
					if type(opts.ensure_installed) == "table" then
						vim.list_extend(opts.ensure_installed, { "codelldb" })
					end
				end,
			},
			opts = function()
				local dap = require("dap")
				if not dap.adapters["codelldb"] then
					require("dap").adapters["codelldb"] = {
						type = "server",
						host = "localhost",
						port = "${port}",
						executable = {
							command = "codelldb",
							args = {
								"--port",
								"${port}",
							},
						},
					}
				end
				for _, lang in ipairs({ "c", "cpp" }) do
					dap.configurations[lang] = {
						{
							type = "codelldb",
							request = "launch",
							name = "Launch file",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
						},
						{
							type = "codelldb",
							request = "attach",
							name = "Attach to process",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					}
				end
			end,
		},
		{
			"echasnovski/mini.surround",
			opts = {
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "gsn",
				},
			},
		},
		-- Use <tab> for completion and snippets (supertab)
		-- first: disable default <tab> and <s-tab> behavior in LuaSnip
		{
			"L3MON4D3/LuaSnip",
			keys = function()
				return {}
			end,
		},
		-- then: setup supertab in cmp
		{
			"hrsh7th/nvim-cmp",
			---@param opts cmp.ConfigSchema
			opts = function(_, opts)
				local has_words_before = function()
					unpack = unpack or table.unpack
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					return col ~= 0
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
				end

				local luasnip = require("luasnip")
				local cmp = require("cmp")
				opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
					{ name = "crates" },
				}))

				opts.mapping = vim.tbl_extend("force", opts.mapping, {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- this way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						-- elseif has_words_before() then
						-- 	cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				})
			end,
		},
	}
end
