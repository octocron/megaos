-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- show file path @ upper right
vim.opt.winbar = "%=%m %f"
vim.opt.list = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

--globally add syntax highlighting
vim.cmd('syntax on')

-- Enable filetype detection
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')

-- Add custom filetype detection for .rasi files
vim.cmd('autocmd BufRead,BufNewFile *.rasi set filetype=rasi')
vim.cmd('autocmd BufRead,BufNewFile *.rasi set syntax=rasi')

-- Define autocmds to set the filetype and enable syntax highlighting for .conf files
vim.cmd('autocmd BufRead,BufNewFile *.conf set filetype=conf')
vim.cmd('autocmd BufRead,BufNewFile *.conf set syntax=conf')

