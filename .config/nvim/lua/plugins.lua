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
return require('packer').startup({
    function(use)
        use 'wbthomason/packer.nvim'

        -- APPEARANCE
        use { 'mhinz/vim-startify', config = [[require('config.startify')]] }
        use { 'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = [[require('config.lualine')]]
        }
        use { 'akinsho/bufferline.nvim', 
            requires = { 'kyazdani42/nvim-web-devicons' }, 
            config = [[require('config.bufferline')]]
        }

        -- THEMES
        use { "morhetz/gruvbox" } 

        -- LSP
        use { 'neovim/nvim-lspconfig', config = [[require('config.nvim-lsp')]] }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-cmdline' }
        use { 'hrsh7th/nvim-cmp',
            requires ={
                'quangnguyen30192/cmp-nvim-ultisnips',
                config = function()
                    require("cmp_nvim_ultisnips").setup{}
                end,
            },
        config = [[require('config.nvim-cmp')]]
        }
        use { 'folke/lsp-colors.nvim' }

        -- SNIPPETS
        use { 'lervag/vimtex' }
        use { 'KeitaNakamura/tex-conceal.vim' }
        use { 'L3MON4D3/LuaSnip', config = [[require('config.luasnip')]] }
        use { 'saadparwaiz1/cmp_luasnip' }
        -- use { 'SirVer/ultisnips', ft ={'tex'}, config = [[require('config.ultisnips')]] }
        -- use { 'quangnguyen30192/cmp-nvim-ultisnips',
            -- config = function()
               -- require("cmp_nvim_ultisnips").setup{}
            -- end,
        -- }

        -- GIT
        use { 'APZelos/blamer.nvim', cmd = 'BlamerToggle', keys = {'<leader>', 'b'}}
        use { 'tpope/vim-fugitive' }
        use { 'Xuyuanp/nerdtree-git-plugin' }

        -- UTILITIES
        use { 'preservim/nerdtree', config = [[require('config.nerdtree')]] }
        use { 'nvim-treesitter/nvim-treesitter',
            config = [[require('config.treesitter')]],
            run = ':TSUpdate',
        }
        use { 'preservim/nerdcommenter', config = [[require('config.nerdcommenter')]] }
        use { 'preservim/tagbar' }
        use { 'ludovicchabant/vim-gutentags' }
        use { 'tpope/vim-surround' }
        use { 'tpope/vim-repeat' }
        use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] }
        use { 'sheerun/vim-polyglot' }
        use { 'jiangmiao/auto-pairs' }
        use { 'junegunn/vim-easy-align' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-telescope/telescope.nvim', config = [[require('config.telescope')]] }
        use { 'BurntSushi/ripgrep' }
       
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        -- open float display when loading plugins
        display = {
            open_fn = require('packer.util').float
        },
    },
})
