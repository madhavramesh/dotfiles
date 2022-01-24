-- shortened commands 
local o = vim.o
local g = vim.g 
local nvim_exec = vim.api.nvim_exec

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- GENERAL MAPPINGS
-- set leader and localleader to space
g.mapleader = ' '
g.maplocalleader = ' '

-- clear search highlighting
-- map('n', '<CR>', ':nohlsearch<CR>')

-- increment/decrement
map('n', '+', '<C-A>')
map('n', '-', '<C-X>')

-- select all
map('n', '<C-A>', 'ggVG')

-- split window navigation 
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-H>', '<C-W><C-H>')
map('n', '<C-L>', '<C-W><C-L>')

-- split window resizing
map('n', '<C-left>', '<C-W><')
map('n', '<C-right>', '<C-W>>')
map('n', '<C-up>', '<C-W>+')
map('n', '<C-down>', '<C-W>-')

-- buffer navigation and deletion
map('n', 'J', ':bprev<CR>')
map('n', 'K', ':bnext<CR>')
map('n', 'Q', ':bd<CR>')

-- move blocks of text 
map('n', '<Leader>j', ':m .+1<CR>==')
map('n', '<Leader>k', ':m .-2<CR>==')
-- map('i', '<Leader>j', '<Esc>:m .+1<CR>==gi')
-- map('i', '<Leader>k', '<Esc>:m .-2<CR>==gi')
map('v', '<Leader>j', ":m '>+1<CR>gv=gv") 
map('v', '<Leader>k', ":m '<-2<CR>gv=gv") 

-- remember meaningful j and k as jumps on jumplist
nvim_exec([[
nnoremap <expr> k (v:count > 10 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 10 ? "m'" . v:count : '') . 'gj'
]], false);

-- disable Ex mode
-- map('n', 'Q', '<Nop>')

-- PLUGIN MAPPINGS
-- NERDTree toggle
map('n', '<C-E>', ':NvimTreeToggle<CR>')
-- map('n', '<C-E>', ':NERDTreeToggle<CR>')

-- Tagbar toggle
map('n', '<C-P>', ':TagbarToggle<CR>')

-- Interactive EasyAlign
map('n', 'ga', '<Plug>(EasyAlign)')
map('x', 'ga', '<Plug>(EasyAlign)')

-- Blamer toggle
map('n', '<leader>b', ':BlamerToggle<CR>')

-- fugitive
map('n', '<leader>gs', ':G<CR>')

-- Move to buffers using Bufferline
map('n', '<leader>1', ':bu 1<CR>')
map('n', '<leader>2', ':bu 2<CR>')
map('n', '<leader>3', ':bu 3<CR>')
map('n', '<leader>4', ':bu 4<CR>')
map('n', '<leader>5', ':bu 5<CR>')
map('n', '<leader>6', ':bu 6<CR>')
map('n', '<leader>7', ':bu 7<CR>')
map('n', '<leader>8', ':bu 8<CR>')
map('n', '<leader>9', ':bu 9<CR>')

-- telescope
map('n', 'ff', ':Telescope find_files<CR>')
map('n', 'fg', ':Telescope live_grep<CR>')
map('n', 'fb', ':Telescope buffers<CR>')
map('n', 'fh', ':Telescope help_tags<CR>')
map('n', 'fm', ':Telescope man_pages<CR>')
