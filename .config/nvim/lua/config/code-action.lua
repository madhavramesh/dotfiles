return {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    config = function()
        vim.api.nvim_command('highlight clear DiffAdd')
        vim.api.nvim_set_var('code_action_menu_show_diff', false)
    end
}
