-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Save, undo
map("n", "<C-s>", ":w!<cr>", { desc = "Save" })
map("i", "<C-s>", "<ESC>:w!<cr>l", { desc = "Save file" })
map("n", "<C-z>", ":u<cr>", { desc = "Undo" })

-- Splits
-- map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
-- map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
-- map("n", "<leader>ss", "<C-w>s", { desc = "Split horizontal" })
-- map("n", "<leader>se", "<C-w>=", { desc = "Splits equal width" })
-- map("n", "<leader>sx", ":close<CR>", { desc = "Close split" })
-- remap first and last non-blank
-- map("n", "<M-h>", "^", { desc = "First non-blank" })
-- map("n", "<M-l>", "g_", { desc = "Last non-blank" })
map("n", "0", "^", { desc = "First non-blank" })
map("n", "$", "g_", { desc = "Last non-blank" })
map("v", "0", "^", { desc = "First non-blank" })
map("v", "$", "g_", { desc = "Last non-blank" })

-- Copy paste
map("n", "<leader><leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader><leader>Y", '"+Y', { desc = "Copy to system clipboard" })
map("n", "<leader><leader>p", [["+p]], { desc = "Paste from system clipboard" })
map("n", "<leader><leader>P", [["+P]], { desc = "Paste from system clipboard" })
map("x", "<leader><leader>r", [["_dP]], { desc = "Replace" })
map("v", "<leader><leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<leader><leader>Y", '"+Y', { desc = "Copy to system clipboard" })
map("v", "<leader><leader>p", [["+p]], { desc = "Paste from system clipboard" })
map("v", "<leader><leader>P", [["+P]], { desc = "Paste from system clipboard" })

-- Execute
-- TODO
map("n", "<leader>R", [[:silent !tmux send-keys -t 1 "\!\!" Enter <CR>]], { desc = "Execute last tmux command" })
-- map("n", "<leader>r", [[:silent !tmux send-keys -t 1 "python " %:p Enter <CR>]], { desc = "Execute Python" })

-- Hop
-- map("n", "s", ":silent HopChar2<cr>", { desc = "HopChar2" })
-- map("n", "<M-s>", ":silent HopPattern<cr>", { desc = "HopPattern" })
-- map("n", "S", ":silent HopWord<cr>", { desc = "HopWord" })

-- Move lines
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<M-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<M-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- TMUX movement
map("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]])
map("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]])
map("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]])
map("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]])

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
