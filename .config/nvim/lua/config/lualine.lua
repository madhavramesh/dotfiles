return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'gruvbox-material',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'filename', 'branch' },
            lualine_c = {},
            lualine_x = { 'diagnostics' },
            lualine_y = { 'filetype', 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    }
}
