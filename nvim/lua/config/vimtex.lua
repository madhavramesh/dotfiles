local g = vim.g
local cmd = vim.cmd

return {
    'lervag/vimtex',
    config = function()
        g.tex_flavor = 'latex'
        g.vimtex_view_method = 'zathura'
        g.vimtex_compiler_method = 'latexmk'

        cmd [[
        let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : './build',
            \ }
        ]]

        g.vimtex_quickfix_mode = 2
        g.vimtex_quickfix_autoclose_after_keystrokes = 3
        g.vimtex_quickfix_open_on_warning = 0
    end
}
