return {
  'nvim-telescope/telescope.nvim',
  cmd = { "Telescope", "TodoTelescope" },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  keys = {
    { '<Leader>ff', ':Telescope find_files<cr>',             desc = 'Search files' },
    { '<Leader>fg', ':Telescope live_grep<cr>',              desc = 'Search text' },
    { '<Leader>fb', ':Telescope buffers<cr>',                desc = 'Search buffers' },
    { '<Leader>ft', ':TodoTelescope keywords=TODO,FIX<cr>',  desc = "Search todos" },
    { '<Leader>fh', ':Telescope help_tags<cr>',              desc = 'Search help tags' },
    { '<Leader>fm', ':Telescope man_pages sections=ALL<cr>', desc = 'Search man pages' },
    { '<Leader>fn', ':Telescope notify<cr>',                 desc = 'Search notifications' },
  },
  config = function()
    local telescope = require('telescope')
    local fb_actions = require("telescope").extensions.file_browser.actions

    -- Set explicit highlight groups for Telescope borders otherwise they get overriden
    -- by gruvbox theme
    vim.cmd [[
      highlight TelescopeBorder guifg=NONE guibg=NONE
      highlight TelescopePromptBorder guifg=NONE guibg=NONE
      highlight TelescopeResultsBorder guifg=NONE guibg=NONE
      highlight TelescopePreviewBorder guifg=NONE guibg=NONE
    ]]

    telescope.setup({
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_width = 0.6, -- available only for layout_config; see :help telescope.layout
          },
        },
        preview_title = false,
        results_title = false,
        prompt_title = false,
        -- in general, don't follow .gitignore, but don't want these still
        file_ignore_patterns = { "node_modules", ".git", ".terraform", "%.jpg", "%.jpeg", "%.png", "%.avi", "%.mp4", '.rustup' },
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
        border = true, 
        borderchars = {
            "─", "│", "─", "│", "╭", "╮", "╯", "╰"
        },
        path_display = { "filename_first", },
      },
      pickers = {
        find_files = {
          hidden = true,
          prompt_title = false,
          preview_title = false,
          results_title = false,
        },
        buffers = {
          sort_lastused = true,
          prompt_title = false,
          preview_title = false,
          results_title = false,
        },
        live_grep = { 
          prompt_title = false,
          preview_title = false,
          results_title = false,
        },
        man_pages = {
          prompt_title = false,
          preview_title = false,
          results_title = false,
        },
        help_tags = {
          prompt_title = false,
          preview_title = false,
          results_title = false,
        },
        -- TODO: Disable prompt_Title, preview_title, and results_title in notify and todo pickers
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- insert mode mappings
              ["<C-n>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-d>"] = fb_actions.remove,
            },
            ["n"] = {
              -- normal mode mappings
              ["a"]  = fb_actions.create,
              ["cw"] = fb_actions.rename,
              ["<Leader>rn"] = fb_actions.rename,
              ["dd"] =  fb_actions.remove
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
