-- shorten commands
local o = vim.o
local g = vim.g
local cmd = vim.cmd

return {
    -- THEME
    -- gruvbox with treesitter support
    {
        'eddyekofo94/gruvbox-flat.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            o.termguicolors = true
            o.background = 'dark'

            g.gruvbox_flat_style = 'dark'
            g.gruvbox_colors = { error = '#ff0000' }
            g.gruvbox_theme = { PmenuSel = { fg = 'black', bg = 'green' }}
            cmd [[colorscheme gruvbox-flat]]
        end,
    },
    -- catppuccin
    -- {
    -- 'catppucin/nvim',
    -- name = 'catppuccin',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    -- o.termguicolors = true
    -- o.background = 'dark'
--
    -- cmd [[colorscheme catppuccin]]
    -- end,
    -- },

    -- APPEARANCE
    -- startup screen for nvim (starter.lua)
    -- statusline (lualine.lua)
    -- show current code context in status line (nvim-navic.lua)
    -- bufferline (bufferline.lua)
    -- highlight indented lines (indent-blankline.lua)
    -- list diagnostics, references, etc.
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'TroubleToggle',
        keys = {
            {
                '<Leader>xx',
                ':TroubleToggle<cr>',
                desc = 'Toggle trouble'
            },
            {
                '<Leader>xw',
                ':TroubleToggle lsp_workspace_diagnostics<cr>',
                desc = 'Toggle workspace trouble'
            },
            {
                '<Leader>xd',
                ':TroubleToggle lsp_document_diagnostics<cr>',
                desc = 'Toggle document trouble'
            },
            {
                '<Leader>xl',
                ':TroubleToggle loclist<cr>',
                desc = 'Toggle loclist trouble'
            },
            {
                '<Leader>xq',
                ':TroubleToggle quickfix<cr>',
                desc = 'Toggle quickfix trouble'
            },
            {
                '<Leader>gr',
                ':TroubleToggle lsp_references<cr>',
                desc = 'Toggle references trouble'
            },
        },
        config = true,
    },
    -- highlight and search todo comments (todo-comments.lua)
    {
        'folke/todo-comments.nvim',
        dependencies = {
          'nvim-telescope/telescope.nvim',
          'nvim-lua/plenary.nvim',
        },
        config = true,
    },
    -- dim inactive splits
    {
        'sunjon/shade.nvim',
        keys = {
            -- need to disable for Mason compatability
            { '<Leader>sh', ':ShadeToggle<cr>', desc = 'Toggle shade' },
        }
    },
    -- dim inactive portions of code
    {
        'folke/twilight.nvim',
        keys = {
            { '<Leader>tw', ':Twilight<cr>', desc = 'Toggle twilight' },
        },
        opts = {
            context = 15,
        }
    },
    -- high-performance color highlighter
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            user_default_options = {
                RRGGBBAA = true,
            }
        }
    },

    -- LSP (linting, formatting, autocompletion)
    -- code actions, diagnostics, formatting, autocompletion (null-ls.lua)
    -- fast autocompletion (coq.lua)
    -- show function signature when you type
    { 'ray-x/lsp_signature.nvim' },
    -- displays lightbulb when code actions are available
    {
        'kosayoda/nvim-lightbulb',
        opts = {
            autocmd = { enabled = true },
        }
    },
    -- pop-up menu for code actions (code-actions.lua)
    -- configs for nvim lsp client (nvim-lsp.lua)
    -- better clangd integration
    { 'p00f/clangd_extensions.nvim' },
    -- FIX: better treesitter and lsp support for Go
    -- use { "ray-x/go.nvim",
    -- dependencies = { -- optional packages
    -- "ray-x/guihua.lua",
    -- "neovim/nvim-lspconfig",
    -- "nvim-treesitter/nvim-treesitter",
    -- },
    -- config = function()
    -- require("go").setup()
    -- end,
    -- event = { "CmdlineEnter" },
    -- ft = { "go", 'gomod' },
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    -- }
    -- Rust support
    {
        'simrat39/rust-tools.nvim',
        ft = "rs",
        config = true,
    },

    -- GIT
    -- git blame (blamer.lua)
    -- basic git commands
    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>b',  ':BlamerToggle<cr>', desc = 'Toggle git blame' },
            { '<leader>gs', ':G<cr>',            desc = 'Toggle git fugitive' },
        },
    },
    -- open github URLs
    { 'tpope/vim-rhubarb' },

    -- UTILITIES
    -- better syntax highlighting and function / class jumps (treesitter.lua)
    -- file-explorer (nvim-tree.lua)
    -- fuzzy finder over lists like files, text, etc. (telescope.lua)
    -- shortcuts for commenting lines (nerdcommenter.lua)
    -- persist and toggle multiple terminals (toggleterm.lua)
    -- easily change parantheses, brackets, quotes in pairs
    { 'tpope/vim-surround' },
    -- insert or delete parantheses, brackets, quotes in pairs
    { 'windwp/nvim-autopairs', config = true },
    -- tree-like view of symbols (symbols-outline.lua)
    -- better window deletion functionality
    { 'famiu/bufdelete.nvim' },
    -- github copilot
    {
        'github/copilot.vim',
        keys = {
            { '<Leader>gd', ':Copilot disable<cr>', desc = 'Disable github copilot' },
            { '<Leader>ge', ':Copilot enable<cr>',  desc = 'Enable github copilot' },
        },
    },
    -- identify inefficient commands
    {
       "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       opts = { max_count = 6 }
    },
    -- FIX: copilot integration with coq
    -- { 'ms-jpq/coq.thirdparty', config = [[require('config.coq-thirdparty')]] }
}
