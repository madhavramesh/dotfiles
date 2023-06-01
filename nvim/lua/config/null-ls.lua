return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        local null_ls = require('null-ls')
        local sources = {
            -- FORMATTING
            -- Python
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,

            -- C/C++
            null_ls.builtins.formatting.clang_format.with({
                extra_args = { "-style=file" }
            }),

            -- Cmake
            null_ls.builtins.formatting.cmake_format,

            -- Golang
            null_ls.builtins.formatting.gofmt,
            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.golines,

            -- Rust
            null_ls.builtins.formatting.rustfmt,

            -- JavaScript/TypeScript
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.prettierd,

            -- Java
            -- null_ls.builtins.formatting.google-java-format,

            -- Text files
            -- null_ls.builtins.formatting.codespell,

            -- LINTING
            -- C/C++
            null_ls.builtins.diagnostics.cppcheck.with({
                args = { "--std=c++20", "--language=c++" },
            }),
            null_ls.builtins.diagnostics.cpplint.with({
                disabled_filetypes = { "c" },
                args = { "-std=c++20" },
                extra_args = { '-filter', '-legal/copyright' },
            }),

            -- Golang
            null_ls.builtins.diagnostics.staticcheck,

            -- Markdown
            null_ls.builtins.diagnostics.markdownlint.with({
                extra_args = { "-r", "~/.markdownlint.yaml" },
            }),

            -- Bash
            null_ls.builtins.diagnostics.shellcheck,
        }

        ---- Formatting on save
        -- Here, only use null-ls for formatting
        local lsp_formatting = function(bufnr)
            vim.lsp.buf.format({
                filter = function(client)
                    -- apply whatever logic you want (in this example, we'll only use null-ls)
                    return client.name == "null-ls"
                end,
                bufnr = bufnr,
            })
        end

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        lsp_formatting(bufnr)
                    end,
                })
            end
        end

        null_ls.setup({
            sources = sources,
            -- format on save
            on_attach = on_attach,
        })
    end
}
