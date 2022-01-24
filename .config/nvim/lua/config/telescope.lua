local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf')

telescope.setup{
    defaults = {
        previewer = true,
        layout_strategy = 'flex',
        preview_cutoff = 1,
        mappings = {
            n = {
                ['q'] = actions.close
            },
        },
    },
}
