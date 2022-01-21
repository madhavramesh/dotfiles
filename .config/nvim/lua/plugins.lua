-- shorten commands
local fn = vim.fn 

-- automatically install Packer if not already installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- manually set python executable for faster load times
-- see https://www.redd.it/r9acxp/
vim.g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.9/bin/python3'

-- only required if you have packer configured as 'opt'
vim.cmd [[ packadd packer.nvim ]]

-- run :PackerCompile whenever a configuration is changed
vim.cmd([[
augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- install packages
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- APPEARANCE
    use { 'ryanoasis/vim-devicons' }

    -- THEMES
    use { "morhetz/gruvbox" } 

    -- LSP
    use { 'neovim/nvim-lspconfig', config = [[require('config.nvim-lsp')]] }
    use { 'hrsh7th/nvim-compe' }

    -- UTILITIES
    use { 'preservim/nerdtree' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use { 'preservim/nerdcommenter', config = [[require('config.nerdcommenter')]] }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] }
    use { 'sheerun/vim-polyglot' }
    use { 'jiangmiao/auto-pairs' }
    use { 'junegunn/vim-easy-align' }

    -- GIT
    use { 'APZelos/blamer.nvim', cmd = 'BlamerToggle', keys = {'<leader>', 'b'}}
    use { 'tpope/vim-fugitive' }
    use { 'Xuyuanp/nerdtree-git-plugin' }
   
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
