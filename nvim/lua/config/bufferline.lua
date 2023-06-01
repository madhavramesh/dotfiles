return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            offsets = {
                {
                    filetype = "nerdtree",
                    text_align = "left"
                }
            },
            numbers = function(opts)
                return string.format('%s', opts.raise(opts.id))
            end,
            right_mouse_command = 'bdelete! %d',
            left_mouse_command = nil,
            middle_mouse_command = nil,
            diagnostics = 'nvim_lsp',
            show_buffer_close_icons = false,
            always_show_bufferline = false
        }
    }
}
