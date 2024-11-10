return {
    'akinsho/nvim-toggleterm.lua',
    version = '*',
    config = function()
        require("toggleterm").setup({
            open_mapping = '<Leader>tt',
            insert_mappings = false,
            direction = 'float',
            float_opts = {
                border = 'curved',
            },
            winbar = {
                enabled = true,
            }
        })

        -- Maps to send current line/visual selection to toggleterm
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>", opts)
        vim.api.nvim_set_keymap("v", "<leader>tv", "<cmd>ToggleTermSendVisualSelection<CR>", opts)

        -- lazygit support
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    end
}
