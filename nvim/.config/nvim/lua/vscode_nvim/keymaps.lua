if vim.g.vscode then
	local function map(mode, lhs, rhs, opts)
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	local function notify(cmd)
		return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
	end

	local function v_notify(cmd)
		return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
	end

	map("n", "<Leader>xr", notify("references-view.findReferences"), { silent = true }) -- language references
	map("n", "<Leader>xd", notify("workbench.actions.view.problems"), { silent = true }) -- language diagnostics
	map("n", "gr", notify("editor.action.goToReferences"), { silent = true })
	-- map("n", "<Leader>rn", notify("editor.action.rename"), { silent = true })
	map("n", "<Leader>fm", notify("editor.action.formatDocument"), { silent = true })
	map("n", "<Leader>ca", notify("editor.action.refactor"), { silent = true }) -- language code actions

	map("n", "<Leader>sg", notify("workbench.action.findInFiles"), { silent = true }) -- use ripgrep to search files
	-- map("n", "<Leader>ts", notify("workbench.action.toggleSidebarVisibility"), { silent = true })
	-- map("n", "<Leader>th", notify("workbench.action.toggleAuxiliaryBar"), { silent = true }) -- toggle docview (help page)
	-- map("n", "<Leader>tp", notify("workbench.action.togglePanel"), { silent = true })
	map("n", "<Leader>fc", notify("workbench.action.showCommands"), { silent = true }) -- find commands
	map("n", "<Leader>ff", notify("workbench.action.quickOpen"), { silent = true }) -- find files
	map("n", "<C-/>", notify("workbench.action.terminal.focus"), { silent = true }) -- terminal window

	-- LazyVim keymaps

	-- better up/down
	map(
		"n",
		"k",
		"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>"
	)
	map(
		"n",
		"j",
		"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>"
	)

	-- Move to window using the <ctrl> hjkl keys
	map("n", "<C-h>", "", { desc = "Go to left window" })
	map("n", "<C-j>", "", { desc = "Go to lower window" })
	map("n", "<C-k>", "", { desc = "Go to upper window" })
	map("n", "<C-l>", "", { desc = "Go to right window" })

	-- Resize window using <ctrl> arrow keys
	map("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	map("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	map("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

	-- buffers
	map("n", "<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
	map("n", "<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")
	map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

	map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
	map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

	-- Clear search with <esc>
	map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

	map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

	-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
	map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
	map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
	map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
	map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
	map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

	-- save file
	map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

	-- better indenting
	map("v", "<", "<gv")
	map("v", ">", ">gv")

	-- new file
	map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

	-- quit
	map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

	-- Own key maps
	map("n", "<C-s>", ":w!<cr>", { desc = "Save" })
	map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
	map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
	map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
	map("n", "<leader>se", "<C-w>=", { desc = "Splits equal width" })
	map("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

	map("n", "<C-z>", ":u<cr>", { desc = "Undo" })
	map("n", "<leader><leader>y", '"+y', { desc = "Copy to system clipboard" })
	map("n", "<leader><leader>Y", '"+Y', { desc = "Copy to system clipboard" })
	map("n", "<leader><leader>p", [["+p]], { desc = "Paste from system clipboard" })
	map("n", "<leader><leader>P", [["+P]], { desc = "Paste from system clipboard" })
	map("v", "<leader><leader>r", [["_dP]], { desc = "Replace" })

	map("i", "<C-s>", "<ESC>:w!<cr>l", { desc = "Save file" })

	-- leader copy to system clipboard
	map("v", "<leader><leader>y", '"+y', { desc = "Copy to system clipboard" })
	map("v", "<leader><leader>Y", '"+Y', { desc = "Copy to system clipboard" })
	map("v", "<leader><leader>p", [["+p]], { desc = "Paste from system clipboard" })
	map("v", "<leader><leader>P", [["+P]], { desc = "Paste from system clipboard" })

	-- Neovim plugin
	map("n", "<space>w", "<C-w>")
	map("n", "<leader>b", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<Cr>")
end
