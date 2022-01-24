require('lualine').setup{
    options = {
        theme = 'gruvbox'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
    }
}

-- require('lualine').setup{
    -- options = {
        -- theme = 'gruvbox',
        -- component_separators = '|',
        -- section_separators = { left = '', right = '' },
    -- },
    -- sections = {
        -- lualine_a = {
            -- { 'mode', separator = { left = '' }, right_padding = 2 },
        -- },
        -- lualine_b = { 'filename', 'branch' },
        -- lualine_c = {
            -- { 'diff', separator = { right = '' }, left_padding = 2 },
        -- },
        -- lualine_x = {'diagnostics'},
        -- lualine_y = { 'fileformat', 'filetype', 'progress' },
        -- lualine_z = {
            -- { 'location', separator = { right = '' }, left_padding = 2 },
        -- },
  -- },
  -- inactive_sections = {},
    -- -- inactive_sections = {
        -- -- -- lualine_a = { 'filename' },
        -- -- lualine_a = {},
        -- -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = { 'location' },
    -- },
    -- tabline = {},
    -- extensions = {}
-- }
