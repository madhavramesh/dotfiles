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
cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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
      floating_window = true, -- false for virtual text only
      floating_window_above_cur_line = true,
      -- floating_window_off_y = 30,
      transparency = 20,
      handler_opts = {
        border = "rounded"
      },
      doc_lines = 2,   -- restrict documentation shown
      zindex = 50,     -- <=50 so that it does not hide completion preview.
      fix_pos = false, -- Let signature window change its position when needed
      toggle_key = 'ts',  -- Press <Alt-x> to toggle signature on and off.
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
  on_attach_lsp_signature(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'ts', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'ca', ':CodeActionMenu<CR>', opts)
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
