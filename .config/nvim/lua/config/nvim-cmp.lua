local o = vim.o 
local cmd = vim.cmd

local cmp = require'cmp'
local luasnip = require'luasnip'
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

o.completeopt = 'menu,menuone,noselect'

-- custom menu icons
kind_icons = {
  Text = '', -- Text
  Method = '', -- Method
  Function = '', -- Function
  Constructor = '', -- Constructor
  Field = '', -- Field
  Variable = '', -- Variable
  Class = '', -- Class
  Interface = 'ﰮ', -- Interface
  Module = '', -- Module
  Property = '', -- Property
  Unit = '', -- Unit
  Value = '', -- Value
  Enum = '', -- Enum
  Keyword = '', -- Keyword
  Snippet = '﬌', -- Snippet
  Color = '', -- Color
  File = '', -- File
  Reference = '', -- Reference
  Folder = '', -- Folder
  EnumMember = '', -- EnumMember
  Constant = '', -- Constant
  Struct = '', -- Struct
  Event = '', -- Event
  Operator = 'ﬦ', -- Operator
  TypeParameter = '', -- TypeParameter
},

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `f
    ["<Tab>"] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end,
    -- ["<Tab>"] = cmp.mapping(
      -- function(fallback)
        -- cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      -- end,
      -- { "i", "s" }
    -- ),
    -- ["<S-Tab>"] = cmp.mapping(
      -- function(fallback)
        -- cmp_ultisnips_mappings.jump_backwards(fallback)
      -- end,
      -- { "i", "s" }
    -- ),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      -- This concatenates the icons with the name of the item kind
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- vim_item.kind = string.format('%s %s', 'kind', vim_item.kind)
      return vim_item
    end
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- load vscode style snippets
-- require('luasnip.loaders.from_vscode').load({paths = '~/.config/nvim'})
