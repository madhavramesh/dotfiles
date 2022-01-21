-- shortened commands
local o = vim.o 
local wo = vim.wo 
local cmd = vim.cmd 
local nvim_exec = vim.api.nvim_exec

-- file settings
o.encoding = 'utf-8'			-- internal reprsentation of characters
o.fileencoding = 'utf-8'		-- encoding for particular file

--general
o.splitright = true			-- open new split panes to right
o.splitbelow = true			-- open new split panes below
o.wildmode = 'longest,list'		-- command line completion
o.wildignore = '*.docx, *.jpg, *.png, *.gif, *.pdf, *.pyc, *.exe, *.flv, *.img, *.xlsx'	-- ignore files with these patterns
o.showmatch = true			-- cursor jumps to matching brace 
o.clipboard = 'unnamedplus'		-- use system clipboard
o.ttyfast = true			-- increase vim scroll speed
o.hidden = true                		-- hides buffers instead of closing them

-- UI
o.number = true				-- line numbers
o.relativenumber = true			-- relative line numbers
o.ignorecase = true			-- ignore case
o.smartcase = true			-- do not ignore case with capitals
o.hlsearch = true			-- highlight search
o.incsearch = true			-- incremental search
o.cursorline = true			-- highlight current line
o.cursorlineopt = 'screenline,number' -- how cursorline is displayed
-- o.cc = 80
o.showcmd = true			-- show partial commands on last line
o.showmode = true			-- show mode on last line 
o.ruler = true				-- display line number and column number

-- tabs, indent
o.tabstop = 4				-- number of spaces tabs count for
o.softtabstop = 4 			-- number of spaces cursor moves when pressing tab 
o.expandtab = true			-- use spaces instead of tabs
o.shiftwidth = 4			-- size of an indent
o.autoindent = true			-- indentation of next line depends on current line
o.smartindent = true			-- indentation depends on code style

-- colorscheme
o.termguicolors = true
o.background = 'dark'
cmd [[au VimEnter * ++nested colorscheme gruvbox]]

-- set search highlight color 
cmd [[highlight Search guifg=bg guibg=Gray]]

-- set cursor line color on visual mode
cmd [[highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40]]
cmd [[highlight LineNr cterm=NONE ctermfg=240 guifg=#2b506e guibg=#000000]]

-- highlight on yank
nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-- don't auto comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
