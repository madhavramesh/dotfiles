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
      g.gruvbox_theme = { PmenuSel = { fg = 'black', bg = 'green' } }
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
    cmd = 'Trouble',
    keys = {
      {
        '<Leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostic (Trouble)'
      },
      {
        '<Leader>xw',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)'
      },
      {
        '<Leader>xd',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)'
      },
      {
        '<Leader>xl',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)'
      },
      {
        '<Leader>xq',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)'
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
    config = function()
      require('hardtime').setup({
        max_count = 6
      })

      -- Reset the default behavior for '-' and '+' (get overriden by hardtime for some reason)
      vim.api.nvim_set_keymap("n", "-", "k^", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "+", "j^", { noremap = true, silent = true })
    end,
  }
  -- FIX: copilot integration with coq
  -- { 'ms-jpq/coq.thirdparty', config = [[require('config.coq-thirdparty')]] }
}
