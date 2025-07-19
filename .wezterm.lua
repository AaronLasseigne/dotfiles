local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 14
config.color_scheme = 'GruvboxDark'

-- Key Bindings
config.keys = {
  -- Tabs
  { key = 'LeftArrow',  mods = 'CMD', action = wezterm.action{ActivateTabRelative=-1} },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action{ActivateTabRelative=1} },
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnCommandInNewTab { cwd=wezterm.home_dir } },
  -- Window
  { key = 'n', mods = 'CMD', action = wezterm.action.SpawnCommandInNewWindow { cwd=wezterm.home_dir } },
  -- Search
  { key = 'f', mods = 'CMD', action = wezterm.action.Search({ CaseInSensitiveString = '' }) }
}

-- Tabs
local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')
tabline.setup({
  options = {
    theme = 'GruvboxDark',
    theme_overrides = {
      tab = {
        active = { fg = '#fbf1c7', bg = '#458588' },
        inactive = { fg = '#fbf1c7', bg = '#282828' },
        inactive_hover = { fg = '#ffffff', bg = '#83a598' },
      }
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = '' -- wezterm.nerdfonts.ple_left_hard_divider_inverse doesn't work for some reason
    }
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = {},
    tabline_c = {},
    tab_active = {
      'index',
      wezterm.nerdfonts.pl_left_soft_divider,
      ' ',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = {
      'index',
      wezterm.nerdfonts.pl_left_soft_divider,
      ' ',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = {},
    tabline_z = { 'domain' }
  },
})
tabline.apply_to_config(config)

return config
