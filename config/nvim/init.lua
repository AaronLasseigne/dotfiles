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
vim.keymap.set('', '<leader>vsc', function() vim.cmd('noh') end, { desc = 'Clear Search Highlight', silent = true })

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
end, { desc = 'Whitespace Cleanup' })

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

local packages = {
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
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy'},
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          }
        }
      },
      gitbrowse = { enabled = true }
    },
    keys = {
      { '<leader>go', ':lua Snacks.gitbrowse.open()<CR>', desc = 'Open in browser' },
    }
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
      { '<leader>aa', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'Any' }, -- n = for a motion/text object (e.g. gaip); x = in visual mode (e.g. vipga)
      { '<leader>a=', 'gaip=', mode = '', desc = '=' },
      { '<leader>a:', 'gaip:', mode = '', desc = ':' }
    },
    init = function()
      require('which-key').add({
        { '<leader>a', group = 'Align' }
      })
    end
  },
  {
    'tpope/vim-speeddating', -- improved increment/decrement support
    keys = {
      { '+', '<Plug>SpeedDatingUp' },
      { '-', '<Plug>SpeedDatingDown' }
    }
  },
  {
    'AaronLasseigne/yank-code.nvim',
    keys = {
      { '<leader>y', ':YankCode<CR>', mode = '', desc = 'Yank Code' }
    },
    config = function()
      require('yank-code').setup()
    end
  },
  { 'tpope/vim-endwise' },
  {
    'tpope/vim-rails',
    keys = {
      { 'gn', '<C-w>gf' },
      { 'go', 'gf' }
    },
    ft = 'ruby'
  },
  'nelstrom/vim-visual-star-search', -- make * and # work with the current visual selection
  {
    'echasnovski/mini.diff',
    version = '*',
    config = function()
      require('mini.diff').setup({
        view = {
          style = 'sign'
        }
      })
      vim.api.nvim_set_hl(0, 'SignColumn', { link = 'Normal' })
    end
  },
  'nvim-treesitter/nvim-treesitter',
  {
    'neovim/nvim-lspconfig',
    init = function()
      vim.lsp.enable('solargraph')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('rust_analyzer')

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      require('which-key').add({
        { '<leader>d', group = 'Diagnostic' }
      })
      vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open' })
      vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Prev' })
      vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Next' })
      vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'List' })

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
          require('which-key').add({
            { '<leader>c', group = 'Code' }
          })
          vim.keymap.set('n', '<leader>cl', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Declaration' })
          vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Definition' })
          vim.keymap.set('n', '<leader>ch', function()
            vim.lsp.buf.hover({ border = 'single' })
          end, { buffer = ev.buf, desc = 'Hover' })
          vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'Implementation' })
          vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Signature' })
          vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'Type Definition' })
          vim.keymap.set('n', '<leader>crn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename' })
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code Action' })
          vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'References' })
        end,
      })
    end
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    opts = {
      keymap = { preset = 'super-tab' },

      completion = {
        menu = {
          draw = {
            treesitter = { 'lsp' }
          }
        }
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' }
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    init = function()
      require('which-key').add({
        { '<leader>f', group = 'Find' }
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffer' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'File' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Search' })
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Selection Search' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
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
      { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Open Diff Split' },
      { '<leader>gD', ':diffoff!<CR><C-w>h:bd<CR>', desc = 'Close Diff Split' },
      { '<leader>gs', ':Git<cr>', desc = 'Status' },
      { '<leader>gb', ':Git blame -w -M -C<cr>', desc = 'Blame'},
      { '<leader>gm', ':Gmove<space>', desc = 'Move' },
      { '<leader>gr', ':GDelete<cr>', desc = 'Delete' }
    },
    init = function()
      require('which-key').add({
        { '<leader>g', group = 'Git' }
      })
    end
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
        true
      }
    },
    config = function()
      require('which-key').add({
        { '<leader>*', hidden = true } -- not sure where this comes from
      })
    end
  },
  {
    'nanozuki/tabby.nvim',
    keys = {
      { '<leader>tg', ':Tabby jump_to_tab<CR>', desc = 'Go To' },
      { '<leader>t<', ':-tabmove<CR>', desc = 'Move Left' },
      { '<leader>t>', ':+tabmove<CR>', desc = 'Move Right' }
    },
    init = function()
      vim.opt.showtabline = 2

      require('which-key').add({
        { '<leader>t', group = 'Tab' },
        { '<leader>v', group = 'Vim' },
        { '<leader>vs', group = 'Search' }
      })

      require('tabby').setup({
        preset = 'tab_only'
      })
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup()
    end
  },
  {
    'mason-org/mason.nvim',
    opts = {}
  },
}

-- Local Config
local local_config_file = '/Users/aaron.lasseigne/.config/nvim/init.local.lua'
local local_config = io.open(local_config_file)
if local_config then
  loadfile(local_config_file, 't', { table = table, packages = packages })()
  io.close(local_config)
end

require('lazy').setup(
  packages,
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
  }
)
