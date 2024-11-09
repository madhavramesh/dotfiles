local g = vim.g
local cmd = vim.cmd


return {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    config = function()
        cmd [[highlight clear DiffAdd]]
        g.code_action_menu_show_diff = false
    end
}
