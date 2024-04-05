-- leader
vim.g.mapleader = ','

-- no more shift
vim.keymap.set('', ';', ':')

-- UI

-- show line numbers
vim.opt.number = true

-- highlight the opening/closing parens, braces, etc
vim.opt.showmatch = true

-- highlight the current line and column
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Tabs/Spacing

-- tabs are 2 spaces
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- use spaces when tabbing
vim.opt.expandtab = true

-- indent is 2 spaces
vim.opt.shiftwidth = 2

-- Cut, Copy, and Paste

-- copy text to the OS clipboard
vim.opt.clipboard = 'unnamedplus'

-- make Y work like C
vim.keymap.set('n', 'Y', 'y$')

-- Search

-- clear search highlighting
vim.keymap.set('', '<leader>cs', function() vim.cmd('noh') end, { silent = true, noremap = true })

-- only search case when an uppercase letter appears
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- make search results appear in the middle of the screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')

-- Plugin Management
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    {
      'morhetz/gruvbox',
      lazy = false,
      priority = 1000, -- load this first
      init = function()
        -- enable true colors
        vim.opt.termguicolors = true

        vim.g.gruvbox_contrast_dark = 'hard'
        vim.g.gruvbox_contrast_light = 'hard'

        vim.cmd('colorscheme gruvbox')
      end
    },
    {
      'vim-airline/vim-airline',
      lazy = false,
      init = function()
        -- always show the status line
        vim.g.laststatus = 2

        -- make it look powerline esque
        vim.g.airline_powerline_fonts = true
        vim.g.airline_theme = 'gruvbox'

        -- pretty tabs
        vim.g['airline#extensions#tabline#enabled'] = true

        -- do not how buffer counts
        vim.g['airline#extensions#tabline#show_tab_nr'] = false

        -- do not show the buffer when only one tab exists
        vim.g['airline#extensions#tabline#show_buffers'] = false
      end
    }
  }
})
