-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { 'powershell.exe' }
config.default_cwd = 'C:\\Users\\Dilip Chauhan\\Desktop\\WORK\\'
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font 'Iosevka NF'
config.font_size = 10
config.color_scheme = 'OneDark (base16)'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 30

-- and finally, return the configuration to wezterm
return config
