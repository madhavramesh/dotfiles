local o = vim.o

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }, -- easy LSP, linter, etc. installer
    config = function()
        -- Set up mason hooks into lspconfig
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                'asm_lsp',              -- Assembly
                'bashls',               -- Bash
                'clangd',               -- C/C++
                'dockerls',             -- Docker
                'eslint',               -- JS[X], TS[X], Vue
                'gopls',                -- Go
                'jedi_language_server', -- Python
                'lua_ls',               -- Lua
                'pyright',              -- Python
                'rust_analyzer',        -- Rust
                'ts_ls',                -- JS[X], TS[X]
                'jsonnet_ls'            -- Jsonnet
            },
        })

        -- DIAGNOSTICS CONFIG
        -- Enable virtual text only on >=warnings, and sort on severity
        vim.diagnostic.config({
            virtual_text = {
                severity = { min = vim.diagnostic.severity.WARN },
            },
            underline = true,
            signs = true,
            float = {
                border = "rounded",
                focus = false,
                show_header = false,
                header = "",
                source = "if_many",
            },
            update_in_insert = false,
            severity_sort = true,
        })

        -- set float border highlight color
        vim.cmd('hi FloatBorder guifg=DarkGray')

        -- combine gutter and number
        o.signcolumn = "number"

        -- show diagnostics on hover
        o.updatetime = 200

        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor',
                }
                vim.diagnostic.open_float(nil, opts)

                -- Let the plugin's setup do this instead
                -- require('nvim-lightbulb').update_lightbulb({ sign = { enabled = true, priority = 12 } })
            end
        })

        -- change appearance of diagnostic signs
        local signs = { Error = "✗", Warn = "", Hint = "", Info = "" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- LANGUAGE SERVER SETUP
        local nvim_lsp = require('lspconfig')
        local coq = require('coq')

        -- handlers to redefine function configs
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        }

        local on_attach_lsp_signature = function(client, bufnr)
            require('lsp_signature').on_attach({
                bind = true,            -- This is mandatory, otherwise border config won't get registered.
                floating_window = true, -- false for virtual text only
                floating_window_above_cur_line = true,
                -- floating_window_off_y = 30,
                transparency = 20,
                handler_opts = {
                    border = "rounded"
                },
                doc_lines = 2,        -- restrict documentation shown
                zindex = 50,          -- <=50 so that it does not hide completion preview.
                fix_pos = false,      -- Let signature window change its position when needed
                toggle_key = '<A-x>', -- Press <Alt-x> to toggle signature on and off.
            })
        end

        -- attach only after lsp connects
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Activate LSP signature on attach.
            on_attach_lsp_signature(client, bufnr)

            -- Mappings.
            local opts = { noremap = true, silent = true }
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gnd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'H', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            --buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', '<Leader>ca', ':CodeActionMenu<CR>', opts)
            -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            -- buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            buf_set_keymap('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev({float={border="rounded"}})<CR>', opts)
            buf_set_keymap('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next({float={border="rounded"}})<CR>', opts)
            -- buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            -- buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

            -- Highlight symbol under cursor
            -- NOTE: This is now covered by Treesitter! See this for potential code:
            -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
        end

        local servers = {
            'asm_lsp',              -- Assembly
            'bashls',               -- Bash
            -- 'clangd',            -- C/C++ NOTE: disabled for clangd_extensions.nvim
            'dockerls',             -- Docker
            'eslint',               -- JS[X], TS[X], Vue
            'gopls',                -- Go
            'jedi_language_server', -- Python
            'pyright',              -- Python
            -- 'rust_analyzer',     -- Rust NOTE: disabled for rust-tools.nvim
            -- 'sumneko_lua',       -- Lua
            'ts_ls',                -- JS[X], TS[X]
            'jsonnet_ls'
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities() -- disable warnings for clangd
        capabilities.offsetEncoding = { "utf-16" }

        for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
                on_attach = on_attach,
                handlers = handlers,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }))
        end

        -- additional clangd setup
        require("clangd_extensions").setup({
            server = coq.lsp_ensure_capabilities({
                on_attach = on_attach,
                handlers = handlers,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }),
            extensions = {
                inlay_hints = {
                    highlight = 'Conceal',
                },
                ast = {
                    role_icons = {
                        type = "",
                        declaration = "",
                        expression = "",
                        specifier = "",
                        statement = "",
                        ["template argument"] = "",
                    },
                    kind_icons = {
                        Compound = "",
                        Recovery = "",
                        TranslationUnit = "",
                        PackExpansion = "",
                        TemplateTypeParm = "",
                        TemplateTemplateParm = "",
                        TemplateParamObject = "",
                    },
                }
            }
        })

        -- additional rust setup
        local rt = require("rust-tools")
        rt.setup({
            -- server = coq.lsp_ensure_capabilities({ FIXME: using snippets here causes deadlock :(
            server = {
                on_attach = function(client, bufnr) -- augment w/ rust-tools functionality
                    -- get default configs
                    on_attach(client, bufnr)

                    -- Attach rust-tools-specific configs
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

                    -- Activate LSP signature on attach.
                    on_attach_lsp_signature(client, bufnr)

                    -- Mappings.
                    local opts = { noremap = true, silent = true }
                    buf_set_keymap('n', '<Leader>em', '<cmd>RustExpandMacro<CR>', opts)
                    buf_set_keymap('n', '<Leader>mu', '<cmd>RustMoveItemUp<CR>', opts)
                    buf_set_keymap('n', '<Leader>md', '<cmd>RustMoveItemDown<CR>', opts)
                    buf_set_keymap('n', '<Leader>oc', '<cmd>RustOpenCargo<CR>', opts)
                    -- TODO: disable for now, see if I like this
                    -- buf_set_keymap('n', 'K', '<cmd>RustHoverActions<CR>', opts)
                end,
                handlers = handlers,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
                settings = {
                    ["rust_analyzer"] = {
                        assist = {
                            importGranularity = "module",
                            importPrefix = "by_self",
                        },
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            },
            -- }),
            tools = {
                inlay_hints = {
                    max_len_align = true,
                },
                hover_actions = {
                    auto_focus = false,
                },
                -- crate_graph = {
                -- backend = "gd",
                -- output = ".crate_graph",
                -- }
            },
        })

        -- additional lua setup
        nvim_lsp.lua_ls.setup(coq.lsp_ensure_capabilities({
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'use', 'require', }
                    }
                }
            }
        }))
    end
}
