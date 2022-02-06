local o = vim.o
local cmd = vim.cmd
-- combine gutter and number
o.signcolumn = "number"

-- change appearance of diagnostic signs 
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- show diagnostics on hover 
o.updatetime = 200

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or {nil, nil}

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    vim.diagnostic.open_float(0, {scope="cursor"})   -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
  end
end
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold * lua _G.LspDiagnosticsPopupHandler()
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb{sign={enabled=true,priority=12}}
augroup END
]]

-- customize how diagnostics are displayed 
-- disable virtual text and sort by severity
vim.diagnostic.config({
   virtual_text = false,
   float = {
       border = 'rounded',
       focus = false,
       show_header = true,
   },
   signs = true,
   underline = true,
   update_in_insert = false,
   severity_sort = true
})

-- handlers to redefine function configs
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
}

-- show function signature when typing function name 
local on_attach_lsp_signature = function(client, bufnr)
  require('lsp_signature').on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      },
      max_height = 5, 
      hint_enable = false,
      transparency = 5,
      toggle_key = 'K',  -- Press <Leader>h to toggle signature on and off.
    })
end

-- LANGUAGE SERVER SETUP
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Disable nvim-lsp formatting; use null-ls formatting
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  
  -- Activate LSP signature on attach 
  -- on_attach_lsp_signature(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', ':CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 
  'pyright', 
  'clangd',
  'bashls',
  'tsserver',
  'cmake', 
  'html',
  'eslint',
  'gopls',
  'julials',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- DIAGNOSTICS (not sure if eslint and prettier set up work yet)
-- nvim_lsp.diagnosticls.setup {
  -- on_attach = on_attach,
  -- filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  -- init_options = {
    -- linters = {
      -- eslint = {
        -- command = 'eslint_d',
        -- rootPatterns = { '.git' },
        -- debounce = 100,
        -- args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        -- sourceName = 'eslint_d',
        -- parseJson = {
          -- errorsRoot = '[0].messages',
          -- line = 'line',
          -- column = 'column',
          -- endLine = 'endLine',
          -- endColumn = 'endColumn',
          -- message = '[eslint] ${message} [${ruleId}]',
          -- security = 'severity'
        -- },
        -- securities = {
          -- [2] = 'error',
          -- [1] = 'warning'
        -- }
      -- },
    -- },
    -- filetypes = {
      -- javascript = 'eslint',
      -- javascriptreact = 'eslint',
      -- typescript = 'eslint',
      -- typescriptreact = 'eslint',
    -- },
    -- formatters = {
      -- eslint_d = {
        -- command = 'eslint_d',
        -- args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        -- rootPatterns = { '.git' },
      -- },
      -- prettier = {
        -- command = 'prettier',
        -- args = { '--stdin-filepath', '%filename' }
      -- }
    -- },
    -- formatFiletypes = {
      -- css = 'prettier',
      -- javascript = 'eslint_d',
      -- javascriptreact = 'eslint_d',
      -- json = 'prettier',
      -- scss = 'prettier',
      -- less = 'prettier',
      -- typescript = 'eslint_d',
      -- typescriptreact = 'eslint_d',
      -- json = 'prettier',
      -- markdown = 'prettier',
    -- }
  -- }
-- }

-- efm (formatting) setup
-- require 'lspconfig'.efm.setup {
  -- init_options = {documentFormatting = true},
  -- settings = {
      -- rootMarkers = {'.git/'},
      -- languages = {
          -- lua = {
            -- {formatCommand = 'lua-format -i', formatStdin = true}
          -- },
          -- python = {
            -- {formatCommand = 'python-format -i', formatStdin = true}
          -- }
      -- }
  -- }
-- }
