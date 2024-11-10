return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function(_, opts)
    vim.cmd [[highlight IndentBlanklineScope guifg='darkgrey' gui=nocombine]]

    require('ibl').setup({
      indent = {
        char = "▏",
      },
      scope = {
        enabled = true,
        highlight = "IndentBlanklineScope", -- Sets the highlight group for scope
        show_start = false,
        show_end = false,
      },
    })
  end,
}
