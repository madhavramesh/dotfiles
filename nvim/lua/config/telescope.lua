return {
    'nvim-telescope/telescope.nvim',
    cmd = { "Telescope", "TodoTelescope" },
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
    },
    keys = { 
        { '<Leader>ff', ':Telescope find_files<cr>', desc = 'Search files' },
        { '<Leader>fg', ':Telescope live_grep<cr>', desc = 'Search text' },
        { '<Leader>fb', ':Telescope buffers<cr>', desc = 'Search buffers' },
        { '<Leader>ft', ':TodoTelescope<cr>', desc = "Search todos" },
        { '<Leader>fh', ':Telescope help_tags<cr>', desc = 'Search help tags' },
        { '<Leader>fb', ':Telescope man_pages<cr>', desc = 'Search buffers' },
    },
    config = function()
        local telescope = require('telescope')
        local fb_actions = require("telescope").extensions.file_browser.actions

        telescope.setup({
            defaults = {
                layout_config = {
                    horizontal = {
                        preview_width = 0.6, -- available only for layout_config; see :help telescope.layout
                    },
                },
                -- in general, don't follow .gitignore, but don't want these still
                file_ignore_patterns = { "node_modules", ".git", ".terraform", "%.jpg", "%.png", '.rustup' },
                -- used for grep_string and live_grep
                vimgrep_arguments = {
                    "rg",
                    "--follow",
                    "--no-heading", -- headings suck with Telescope
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--no-ignore",
                    "--trim",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    sort_lastused = true,
                },
            },
            extensions = {
                file_browser = {
                    mappings = {
                        i = {
                        -- insert mode mappings
                            ["<C-n>"] = fb_actions.create,
                            ["<C-r>"] = fb_actions.rename,
                            ["<C-d>"] = fb_actions.remove,
                        }
                    }
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
            }
        })

        telescope.load_extension('file_browser')
        telescope.load_extension('ui-select')
    end
}
