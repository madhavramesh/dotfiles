local null_ls = require('null-ls')

local sources = {
      -- Text files 
      -- null_ls.builtins.formatting.codespell,

      -- Python
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      -- Java 
      -- null_ls.builtins.formatting.google-java-format,

      -- C/C++
      null_ls.builtins.formatting.clang_format.with({
              extra_args = function(params)
                  return params.options 
                      and params.options.tabSize
                      and {
                          "--tab-width", 
                          params.options.tabSize,
                      }
                  end,
      }),

      -- Cmake
      null_ls.builtins.formatting.cmake_format,

      -- Golang
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.golines,

      -- JavaScript/TypeScript
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.prettierd
 }

null_ls.setup({
    sources = sources, 
    -- format on save 
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then 
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
            augroup END
            ]])
        end
    end,
})      
