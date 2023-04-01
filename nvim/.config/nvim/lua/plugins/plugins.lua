if true then
	return {
		{
			"nvim-telescope/telescope.nvim",
			enabled = not vim.g.vscode,
			keys = {
				-- disable the keymap to grep files
				{ "<leader><space>", false },
			},
		},
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
				{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
				"mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{
					"hrsh7th/cmp-nvim-lsp",
					cond = function()
						return require("lazyvim.util").has("nvim-cmp")
					end,
				},
			},
			---@class PluginLspOpts
			opts = {
				-- options for vim.diagnostic.config()
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
				-- LSP Server Settings
				---@type lspconfig.options
				servers = {
					jsonls = {},
					lua_ls = {
						-- mason = false, -- set to false if you don't want this server to be installed with mason
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					},
				},
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			},
			---@param opts PluginLspOpts
			config = function(_, opts)
				-- setup autoformat
				require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat
				-- setup formatting and keymaps
				require("lazyvim.util").on_attach(function(client, buffer)
					require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
					require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
				end)

				-- diagnostics
				for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
				vim.diagnostic.config(opts.diagnostics)

				local servers = opts.servers
				local capabilities =
					require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

				local function setup(server)
					local server_opts = vim.tbl_deep_extend("force", {
						capabilities = vim.deepcopy(capabilities),
					}, servers[server] or {})

					if opts.setup[server] then
						if opts.setup[server](server, server_opts) then
							return
						end
					elseif opts.setup["*"] then
						if opts.setup["*"](server, server_opts) then
							return
						end
					end
					require("lspconfig")[server].setup(server_opts)
				end

				local have_mason, mlsp = pcall(require, "mason-lspconfig")
				local available = have_mason and mlsp.get_available_servers() or {}

				local ensure_installed = {} ---@type string[]
				for server, server_opts in pairs(servers) do
					if server_opts then
						server_opts = server_opts == true and {} or server_opts
						-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
						if server_opts.mason == false or not vim.tbl_contains(available, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end

				if have_mason then
					mlsp.setup({ ensure_installed = ensure_installed })
					mlsp.setup_handlers({ setup })
				end
			end,
		},
		-- add more treesitter parsers
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"bash",
					"help",
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
				},
			},
		},
		{
			"aserowy/tmux.nvim",
			enabled = not vim.g.vscode,
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
			enabled = not vim.g.vscode,
			event = "BufRead",
			config = function()
				require("hop").setup()
				vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
				vim.api.nvim_set_keymap("n", "<M-s>", ":HopPattern<cr>", { silent = true })
				vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
			end,
		},
		{
			"rmagatti/auto-session",
			enabled = not vim.g.vscode,
			opts = {
				log_level = "error",
				auto_session_supress_dirs = { "~/", "~/Downloads" },
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			ft = "markdown",
			build = function()
				vim.fn["mkdp#util#install"]()
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
		{
			"nvim-treesitter/nvim-treesitter-context",
		},
	}
end
