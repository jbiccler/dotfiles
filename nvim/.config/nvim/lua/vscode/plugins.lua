
-- packer.nvim config
-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
-- configure plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
    "phaazon/hop.nvim",
    config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "<leader><leader>s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "<leader><leader><M-s>", ":HopPattern<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "<leader><leader>S", ":HopWord<cr>", { silent = true })
    end,
    }

    -- surround text objects
    use { 'echasnovski/mini.surround', branch = 'stable' }
    -- comment/uncomment
    use { 'echasnovski/mini-comment.nvim', branch = 'stable' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end
)