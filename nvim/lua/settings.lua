-- shortened commands
local o = vim.o 
local bo = vim.bo
local wo = vim.wo 
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd 
local nvim_exec = vim.api.nvim_exec

-- file settings
o.encoding = 'utf-8'			-- internal representation of characters
o.fileencoding = 'utf-8'		-- encoding for particular file

-- general
o.mouse = 'a'
o.splitright = true			-- open new split panes to right
o.splitbelow = true			-- open new split panes below
o.wildmode = 'longest,list'	-- command line completion
o.wildignore = '*.docx, *.jpg, *.png, *.gif, *.pdf, *.pyc, *.exe, *.flv, *.img, *.xlsx'	-- ignore files with these patterns
o.showmatch = true			-- cursor jumps to matching brace 
o.clipboard = 'unnamedplus'	-- use system clipboard
o.ttyfast = true			-- increase vim scroll speed
o.textwidth = 100           -- wrap text at 100 characters
o.colorcolumn = '100'       -- create vertical line at 100 characters
o.hidden = true             -- hides buffers instead of closing them
o.secure = true

-- UI
o.number = true				-- line numbers
o.relativenumber = true		-- relative line numbers
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
o.tabstop = 2				-- number of spaces tabs count for
o.softtabstop = 2 			-- number of spaces cursor moves when pressing tab 
o.expandtab = true			-- use spaces instead of tabs
o.shiftwidth = 2			-- size of an indent
o.autoindent = true			-- indentation of next line depends on current line
o.smartindent = true		-- indentation depends on code style

-- undofile 
o.undodir = fn.stdpath('config') .. '/undo'
o.undofile = true

-- set cursorline highlight color 
cmd [[hi CursorLine guibg=#3c3836]]
-- set colorcolumn highlight color 
cmd [[hi ColorColumn guibg=#3c3836]]
-- set search highlight color 
cmd [[hi search cterm=bold ctermfg=239 ctermbg=109 gui=bold guifg=#504945 guibg=#83a598]]
-- set cursor line color on visual mode
if (o.background == 'dark') then
  cmd [[hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a]]
else
  cmd [[hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af]]
end

-- don't auto comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Luasnip triggers
cmd [[
    smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
    smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

-- change nvim-cmp menu colors
-- cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
-- cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
-- cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
-- cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#076678]]
-- cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#076678]]
-- cmd [[highlight! CmpItemKindText guibg=NONE guifg=#076678]]
-- cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
-- cmd [[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]]
-- cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
-- cmd [[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
-- cmd [[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]
