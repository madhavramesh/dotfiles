g = vim.g
fn = vim.fn

g.startify_lists = {
    { type = 'sessions', header = {'Sessions'} }, 
    { type = 'files', header = {'Recent Files'} }, 
    { type = 'dir', header = {'Recent Files in ' .. fn.getcwd()} }, 
    { type = 'bookmarks', header = {'Bookmarks'} }, 
    { type = 'commands', header = {'Commands'} }
}
