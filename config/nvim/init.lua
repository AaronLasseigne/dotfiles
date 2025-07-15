-- Core

-- leader
vim.g.mapleader = ','

-- no more shift
vim.keymap.set('', ';', ':')

-- spell checking
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

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
vim.keymap.set('', '<leader>cs', function() vim.cmd('noh') end, { silent = true })

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

-- Misc

-- clean whitespace
vim.keymap.set('', '<leader>W', function()
  local save_cursor = vim.fn.getpos('.')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
end)

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
      end,
      config = function()
        vim.cmd('colorscheme gruvbox')
      end
    },
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-lualine/lualine.nvim',
      lazy = false,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      init = function()
        require('lualine').setup {
          options = {
            theme = 'gruvbox'
          },
          sections = {
            lualine_c = { { 'filename', path = 1 } }
          }
        }
      end
    },
    'jiangmiao/auto-pairs', -- automatically adds closing paren, quote, etc
    'wellle/targets.vim', -- adds lots of handy additional target options
    'michaeljsmith/vim-indent-object', -- adds vii and vaI for targeting around indentation
    'tpope/vim-repeat', -- adds '.' support for surround and speeddating
    'tpope/vim-surround', -- change surrounding stuff (parens, quotes, tags, etc)
    {
      'AndrewRadev/switch.vim', -- alternate between items in a predefined list (e.g. true, false)
      init = function()
        vim.g.switch_mapping = '<leader>s'

        vim.g.switch_custom_definitions = {
          { 'to ', 'to_not ' },
          { 'const ', 'let ' },
          { 'hide', 'show' },
          { 'TRUE', 'FALSE' }
        }
      end
    },
    {
      'jpalardy/vim-slime', -- send text from vim to a tmux window (usually a repl)
      init = function()
        vim.g.slime_target = 'tmux'
      end
    },
    {
      'junegunn/vim-easy-align',
      keys = {
        { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } }, -- n = for a motion/text object (e.g. gaip); x = in visual mode (e.g. vipga)
        { '<leader>a=', 'gaip=', mode = '' },
        { '<leader>a:', 'gaip:', mode = '' }
      }
    },
    {
      'tpope/vim-speeddating', -- improved increment/decrement support
      keys = {
        { '+', '<Plug>SpeedDatingUp' },
        { '-', '<Plug>SpeedDatingDown' }
      }
    },
    {
      'AaronLasseigne/yank-code',
      keys = {
        { '<leader>y', '<Plug>YankCode', mode = '' }
      }
    },
    {
      'tpope/vim-endwise', -- adds 'end' to Ruby blocks
      ft = 'ruby'
    },
    {
      'tpope/vim-rails',
      keys = {
        { 'gn', '<C-w>gf' },
        { 'go', 'gf' }
      },
      ft = 'ruby'
    },
    {
      'dense-analysis/ale', -- syntax checking
      lazy = false,
      keys = {
        { '<leader>ed', ':ALEDetail<CR>' },
        { '<leader>et', ':ALEToggle<CR>' }
      },
      init = function()
        vim.g.ale_linters = { erb = {} }

        vim.g.ale_ruby_rubocop_executable = 'bundle'
        vim.g.ale_ruby_rubocop_options = '-D'
      end
    },
    'nelstrom/vim-visual-star-search', -- make * and # work with the current visual selection
    {
      'lewis6991/gitsigns.nvim',
      init = function()
        require('gitsigns').setup {
          on_attach = function(bufnr)
            local gitsigns = require('gitsigns')
            vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame)

            vim.api.nvim_set_hl(0, 'GitsignsCurrentLineBlame', { link = 'Todo' })
          end
        }
      end
    },
    'nvim-treesitter/nvim-treesitter',
    {
      'neovim/nvim-lspconfig',
      init = function()
        local lspconfig = require('lspconfig')
        lspconfig.solargraph.setup {}
        lspconfig.ts_ls.setup {}
        lspconfig.lua_ls.setup {}

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)

        vim.diagnostic.config({
          virtual_text = true -- show diagnostics
        })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            -- vim.keymap.set('n', '<leader>f', function()
            --   vim.lsp.buf.format { async = true }
            -- end, opts)
          end,
        })
      end
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      init = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      end,
      config = function()
        require('telescope').setup {
          pickers = {
            buffers = {
              mappings = {
                n = {
                  ['d'] = 'delete_buffer'
                }
              }
            }
          }
        }
      end
    },
    {
      'tpope/vim-fugitive', -- support for git
      keys = {
        { '<leader>gd', ':Gdiffsplit<CR>' },
        { '<leader>gD', ':diffoff!<CR><C-w>h:bd<CR>' },
        { '<leader>gs', ':Git<cr>' },
        { '<leader>gb', ':Git blame -w -M -C<cr>' },
        { '<leader>gm', ':Gmove<space>' },
        { '<leader>gr', ':GDelete<cr>' }
      }
    }
  },
},
{ -- Lazy settings
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  }
})
