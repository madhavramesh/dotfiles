return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
    dependencies = {
        -- better highlighting, refactoring for treesitter
        { 'nvim-treesitter/nvim-treesitter-refactor' },
        -- better textobject selection, moving, swapping for treesitter
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        -- better function contexts with treesitter
        { 'nvim-treesitter/nvim-treesitter-context' },
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                -- "cmake",
                "css",
                "dockerfile",
                "go",
                "gomod",
                "glsl",
                "html",
                "javascript",
                "json",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "proto",
                "python",
                "regex",
                "rust",
                "typescript",
                "toml",
                "yaml",
            },
            -- Built-in modules
            incremental_selection = {
                              -- Easier selection
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = "<Tab>",
                    node_incremental = "<CR>",
                    node_decremental = "<S-CR>",
                },
            },
            indent = {
                enable = true,
            },

            ---- installed modules
            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            },
            refactor = {
                -- highlight_definitions = {
                -- enable = true,
                -- clear_on_cursor_move = true,
                -- },
                -- highlight_current_scope = { enable = true }, -- kinda annoying when it flickers rn
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                        ["ir"] = "@parameter.inner",
                        ["ar"] = "@parameter.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
                -- treesitter-enhanced movements
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
        }

        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        vim.o.foldenable = false

        require("treesitter-context").setup({
            enable = true,
            separator = '-',
        })
    end
}
