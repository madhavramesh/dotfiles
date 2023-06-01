local g = vim.g

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = "Neotree",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim'
    },
    keys = {
        { '<C-e>', '<cmd>Neotree reveal toggle<cr>', desc = 'Toggle filetree' },
    },
    config = function()
        g.neo_tree_remove_legacy_commands = 1

        require('neo-tree').setup({
            filesystem = {
                commands = {
                    -- Override delete to use trash instead of rm
                    delete = function(state)
                        local path = state.tree:get_node().path
                        vim.fn.system({ "trash", vim.fn.fnameescape(path) })
                        require("neo-tree.sources.manager").refresh(state.name)
                    end,
                }
            },
            window = {
                mappings = {
                    ["H"] = "toggle_hidden",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                }
            }
        })
    end
}
