return {
    'APZelos/blamer.nvim',
    cmd = 'BlamerToggle',
    keys = { '<leader>b' },  -- Corrected keybinding
    config = function()
        vim.api.nvim_set_var('blamer_enabled', 1)
        vim.api.nvim_set_var('blamer_delay', 250)
        vim.api.nvim_set_var('blamer_show_in_insert_modes', 0)
        vim.api.nvim_set_var('blamer_show_in_visual_modes', 0)

        vim.api.nvim_command('highlight Blamer guifg=lightgrey')
    end
}
