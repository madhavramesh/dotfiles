local g = vim.g

return {
    'preservim/nerdcommenter',
    lazy  = false,
    keys = { '<leader>cc', '<leader>cu' },
    config = function()
        g.NERDCreateDefaultMappings = 1
        g.NERDSpaceDelims = 1
        g.NERDCompactSexyComs = 1
        g.NERDCommentEmptyLines = 1
        g.NERDTrimTrailingWhitespace = 1
        g.NERDToggleCheckAllLines = 1
    end
}
