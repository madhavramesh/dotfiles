local g = vim.g
local cmd = vim.cmd

-- disable statusline in NvimTree 
cmd([[ au BufEnter, BufWinEnter, WinEnter, CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else set laststatus=2 | endif ]])

require'nvim-tree'.setup {
    auto_close = true,
    open_on_tab = true,
    update_focused_file = {
        enable = true, 
        update_cwd = false,
        ignore_list = {}
    },
    view = {
        width = 25,
        height = 25,
        side = 'left',
        auto_resize = true
    }
}
