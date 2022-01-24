require('nvim-treesitter.configs').setup {
  highlight = {
    enable = false,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "c",
    "cmake",
    "cpp",
    "css",
    "go",
    "html",
    "java",
    "javascript",
    "julia",
    "lua",
    "python",
    "typescript",
    "vim",
  },
}
--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
