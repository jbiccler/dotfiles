return {
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
        { "<leader>r",     function() end,                                                 mode = { "n", "x" },       desc = "+REPL" },
        { "<leader>rm",    function() end,                                                 mode = { "n", "x" },       desc = "+Mark" },
        { "<leader>rs",    function() require("iron.core").run_motion("send_motion") end,  desc = "Send Motion" },
        { "<leader>rs",    function() require("iron.core").visual_send() end,              mode = { "v" },            desc = "Send" },
        { "<leader>rl",    function() require("iron.core").send_line() end,                desc = "Send Line" },
        { "<leader>rt",    function() require("iron.core").send_until_cursor() end,        desc = "Send Until Cursor" },
        { "<leader>rf",    function() require("iron.core").send_file() end,                desc = "Send File" },
        { "<leader>r<cr>", function() require("iron.core").send(nil, string.char(13)) end, desc = "ENTER" },
        { "<leader>rI",    function() require("iron.core").send(nil, string.char(03)) end, desc = "Interrupt" },
        { "<leader>rC",    function() require("iron.core").close_repl() end,               desc = "Close REPL" },
        { "<leader>rc",    function() require("iron.core").send(nil, string.char(12)) end, desc = "Clear" },
        { "<leader>rms",   function() require("iron.core").send_mark() end,                desc = "Send Mark" },
        { "<leader>rmm",   function() require("iron.core").run_motion("mark_motion") end,  desc = "Mark Motion" },
        { "<leader>rmv",   function() require("iron.core").mark_visual() end,              mode = { "v" },            desc = "Send Visual" },
        { "<leader>rmr",   function() require("iron.marks").drop_last() end,               desc = "Remove Mark" },
        { "<leader>rR",    "<cmd>IronRepl<cr>",                                            desc = "REPL" },
        { "<leader>rS",    "<cmd>IronRestart<cr>",                                         desc = "Restart" },
        { "<leader>rF",    "<cmd>IronFocus<cr>",                                           desc = "Focus" },
        { "<leader>rH",    "<cmd>IronHide<cr>",                                            desc = "Hide" },
    },
    config = function(_, opts)
        local iron = require("iron.core")
        iron.setup(opts)
    end,
}
