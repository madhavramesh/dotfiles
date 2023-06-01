local header_art =
[[
 ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
 │││├┤ │ │╰┐┌╯││││
 ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]]

-- startup screen for nvim
return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        local starter = require('mini.starter')
        starter.setup({
            evaluate_single = true,
            items = {
                starter.sections.recent_files(10, false, false),
                starter.sections.builtin_actions(),
            },
            content_hooks = {
                function(content)
                    local blank_content_line = { { type = 'empty', string = '' } }
                    local section_coords = starter.content_coords(content, 'section')
                    -- Insert backwards to not affect coordinates
                    for i = #section_coords, 1, -1 do
                        table.insert(content, section_coords[i].line + 1, blank_content_line)
                    end
                    return content
                end,
                starter.gen_hook.adding_bullet("» "),
                starter.gen_hook.aligning('center', 'center'),
            },
            header = header_art,
            footer = '',
        })

        vim.cmd([[
          augroup MiniStarterJK
            au!
            au User MiniStarterOpened nmap <buffer> j <Cmd>lua MiniStarter.update_current_item('next')<CR>
            au User MiniStarterOpened nmap <buffer> k <Cmd>lua MiniStarter.update_current_item('prev')<CR>
          augroup END
        ]])
    end
}
