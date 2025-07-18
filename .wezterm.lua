local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.font_size = 14
config.color_scheme = 'GruvboxDark'
config.default_cwd = '~/'

-- Key Bindings
config.keys = {
  { key = 'LeftArrow',  mods = 'CMD', action = wezterm.action{ActivateTabRelative=-1} },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action{ActivateTabRelative=1} },
  { key = 'f', mods = 'CMD', action = wezterm.action.Search({ CaseInSensitiveString = '' }) }
}

-- Tabs
local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')
tabline.setup({
  options = {
    theme = 'GruvboxDark'
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = {},
    tabline_c = {},
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = {
      'index',
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
