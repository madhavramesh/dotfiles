" ==== PLUGINS ====
if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
    " ==== APPEARANCE ====
    Plug 'vim-airline/vim-airline'                              " bottom status bar
    Plug 'vim-airline/vim-airline-themes'                       " themes for bottom status bar
    Plug 'ryanoasis/vim-devicons'                               " filetype icons

    " ==== THEMES ==== 
    Plug 'morhetz/gruvbox'                                      " gruvbox dark medium
   
    " ==== LSP ====
    Plug 'neovim/nvim-lspconfig'                                " initializing language servers 
    Plug 'hrsh7th/nvim-compe'
    " Plug 'hrsh7th/cmp-nvim-lsp'
    " Plug 'hrsh7th/cmp-buffer'
    " Plug 'hrsh7th/cmp-path'
    " Plug 'hrsh7th/cmp-cmdline'
    " Plug 'hrsh7th/nvim-cmp'
    
    " ==== SNIPPETS ====
    " Plug 'SirVer/ultisnips'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " ==== UTILITIES ====
    Plug 'preservim/nerdtree'                                   " files and directories tree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " parses code into syntax tree
    Plug 'preservim/nerdcommenter'                              " quickly comment code
    Plug 'tpope/vim-surround'                                   " quickly edit surroundings (brackets, html tags, etc.)
    Plug 'tpope/vim-repeat'                                     " fixes . notation for plugins
    Plug 'lukas-reineke/indent-blankline.nvim'                  " indentation guides for lines
    Plug 'sheerun/vim-polyglot'                                 " language packs
    Plug 'jiangmiao/auto-pairs'                                 " insertion/deletion of brackets, parantheses, etc. in pairs
    Plug 'junegunn/vim-easy-align'                              " align paragraphs around a character

    " ==== GIT ====
    Plug 'APZelos/blamer.nvim'                                  " git blame plugin
    Plug 'tpope/vim-fugitive'                                   " git commands
    Plug 'Xuyuanp/nerdtree-git-plugin'                          " shows git status flags in NERDTree
call plug#end()
