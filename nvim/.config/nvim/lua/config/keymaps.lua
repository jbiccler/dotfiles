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

-- Hop
-- map("n", "s", ":silent HopChar2<cr>", { desc = "HopChar2" })
-- map("n", "<M-s>", ":silent HopPattern<cr>", { desc = "HopPattern" })
-- map("n", "S", ":silent HopWord<cr>", { desc = "HopWord" })

-- Move lines
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("i", "<M-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<M-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- TMUX movement
-- map("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]])
-- map("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]])
-- map("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]])
-- map("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]])

-- Smart Splits
if not vim.g.vscode then
	map("n", "<A-h>", "<cmd> lua require('smart-splits').resize_left()<cr>")
	map("n", "<A-j>", "cmd> lua require('smart-splits').resize_down()<cr>")
	map("n", "<A-k>", "<cmd> lua require('smart-splits').resize_up()<cr>")
	map("n", "<A-l>", "<cmd> lua require('smart-splits').resize_right()<cr>")
	-- moving between splits
	map("n", "<C-h>", "<cmd> lua require('smart-splits').move_cursor_left()<cr>")
	map("n", "<C-j>", "<cmd> lua require('smart-splits').move_cursor_down()<cr>")
	map("n", "<C-k>", "<cmd> lua require('smart-splits').move_cursor_up()<cr>")
	map("n", "<C-l>", "<cmd> lua require('smart-splits').move_cursor_right()<cr>")
	-- map("n", "<C-\\>", "<cmd> lua require('smart-splits').move_cursor_previous()<cr>")
	-- swapping buffers between windows
	map("n", "<leader><leader>h", "<cmd> lua require('smart-splits').swap_buf_left()<cr>")
	map("n", "<leader><leader>j", "<cmd> lua require('smart-splits').swap_buf_down()<cr>")
	map("n", "<leader><leader>k", "<cmd> lua require('smart-splits').swap_buf_up()<cr>")
	map("n", "<leader><leader>l", "<cmd> lua require('smart-splits').swap_buf_right()<cr>")
end

-- Disable default nvim keymaps
vim.keymap.del("n", "[l")
vim.keymap.del("n", "]l")
vim.keymap.del("n", "[L")
vim.keymap.del("n", "]L")

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Helper function to check if the current Tmux window is zoomed
local function is_tmux_window_zoomed()
	-- Execute tmux command to get the zoom flag for the current window.
	-- #{window_zoomed_flag} returns '1' if a pane in the window is zoomed, '0' otherwise.
	local zoomed_status = vim.fn.system('tmux display-message -p -F "#{window_zoomed_flag}"')

	-- Trim whitespace (especially newline) and convert to boolean
	return (string.gsub(zoomed_status, "%s+", "") == "1")
end

-- Helper function to check if Tmux is currently running
local function is_tmux_running()
	-- The $TMUX environment variable is set by the tmux server
	-- in every pane attached to a session.
	-- If this variable exists and is not empty, it indicates that
	-- the current Neovim instance is running inside a tmux session.
	return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
end

--  Helper function: Get the current number of active panes in the current Tmux window
local function get_tmux_pane_count()
	-- Execute tmux command to get the total number of panes in the current window.
	-- #{window_panes} is a tmux format that returns the count of panes.
	local pane_count_str = vim.fn.system('tmux display-message -p "#{window_panes}"')

	-- Trim whitespace (like trailing newlines) and convert the string to a number.
	-- If tonumber fails (e.g., tmux not running, or unexpected output), default to 0.
	local pane_count = tonumber(pane_count_str) or 0
	return pane_count
end

-- Defines a function to send a command to the last active Tmux pane
local function send_to_tmux_last_pane(command_to_send)
	-- Escapes double quotes within the command to be sent to the shell,
	-- as the command itself will be wrapped in double quotes for tmux send-keys.
	local escaped_command = command_to_send:gsub('"', '\\"')

	-- Constructs the full tmux command
	local pane_count = get_tmux_pane_count()
	local tmux_command = ""
	if pane_count == 1 then
		vim.fn.system("tmux split-window -v")
		tmux_command = string.format('tmux send-keys "%s" C-m', escaped_command)
	else
		if is_tmux_window_zoomed() then
			-- Unzoom first to toggle and then send
			tmux_command = string.format('tmux resize-pane -Z -t0 && tmux send-keys -t -1 "%s" C-m', escaped_command)
		else
			-- Second pane is already visible
			tmux_command = string.format('tmux send-keys -t -1 "%s" C-m', escaped_command)
		end
	end

	-- Executes the tmux command in the shell
	-- vim.fn.system() runs the command synchronously and captures its output.
	-- For commands where you don't need output, you could use vim.cmd("! " .. tmux_command)
	-- or vim.loop.spawn for asynchronous execution if performance is critical for very long commands.
	print(tmux_command)
	vim.fn.system(tmux_command)
	-- vim.cmd("silent !" .. tmux_command)
end

-- Defines the main Neovim function to check filetype and send command
function _G.SendFiletypeCommandToTmux()
	if not is_tmux_running() then
		return print("Tmux is not running. Please start Tmux first.")
	end
	-- Get the current buffer's filetype
	local filetype = vim.bo.filetype
	local command = ""

	-- Define commands based on filetype
	if filetype == "python" then
		command = "python3 %" -- Run the current Python file
	elseif filetype == "sh" or filetype == "bash" then
		command = "bash %" -- Execute the current shell script
	elseif filetype == "markdown" then
		command = "pandoc % -o output.html --standalone --toc --css ~/.config/pandoc/pandoc.css" -- Example: convert markdown to HTML
	elseif filetype == "lua" then
		command = "lua %" -- Run the current Lua file
	elseif filetype == "go" then
		command = "go run %" -- Run the current Go file
	elseif filetype == "rust" then
		command = "cargo run" -- Assumes you are in the project root; otherwise, "rustc % && ./$(basename % .rs)"
	elseif filetype == "c" or filetype == "cpp" then
		-- For C/C++, compile and then run.
		local base_name = vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
		local compiler = (filetype == "c") and "gcc" or "g++"
		command =
			string.format("%s %s -o %s && ./%s", compiler, vim.fn.shellescape(vim.fn.expand("%")), base_name, base_name)
	else
		-- Default command if filetype is not explicitly handled
		command = "ls -al"
		print("No specific command for filetype '" .. filetype .. "'. Sending default command: " .. command)
	end

	-- Send the determined command to Tmux
	if command ~= "" then
		send_to_tmux_last_pane(command)
	else
		print("No command determined for filetype: " .. filetype)
	end
end

-- Exec file type specific command in last tmux pane
-- vim.keymap.del("n", "<leader>cx")
map("n", "<leader>cx", "<cmd>lua SendFiletypeCommandToTmux()<CR>", { desc = "Send filetype-specific command to Tmux" })
