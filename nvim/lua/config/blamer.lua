local g = vim.g
local cmd = vim.cmd

return {
    'APZelos/blamer.nvim',
    cmd = 'BlamerToggle',
    keys = { '<leader>', 'b' },
    config = function()
        g.blamer_enabled = 1
        g.blamer_delay = 250
        g.blamer_show_in_insert_modes = 0
        g.blamer_show_in_visual_modes = 0

        cmd('highlight Blamer guifg=lightgrey')
    end
}
