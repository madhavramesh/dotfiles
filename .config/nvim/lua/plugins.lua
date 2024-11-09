-- automatically install lazy if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- manually set python executable for faster load times
-- see https://www.redd.it/r9acxp/
vim.g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.11/bin/python3'

-- install packages
require('lazy').setup('config')
