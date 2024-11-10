-- shortened commands
local g = vim.g
local nvim_exec = vim.api.nvim_exec

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- GENERAL MAPPINGS
-- set leader and localleader to space
g.mapleader = ' '
g.maplocalleader = ' '

-- clear search highlighting
-- map('n', '<Leader>hi<CR>', ':noh<CR>')

-- increment/decrement
map('n', '+', '<C-A>')
map('n', '-', '<C-X>')

-- select all
map('n', '<C-A>', 'ggVG')

-- split window creation
map('n', '<Leader>d', ':sp<CR>')
map('n', '<Leader>r', ':vsp<CR>')

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
map('n', 'Q', ':<C-w>q<CR>')

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
--map('n', 'Q', '<Nop>')

-- github copilot
map('i', '<C-e>', 'copilot#Accept("<CR>")', { expr = true })
g.copilot_no_tab_map = true
