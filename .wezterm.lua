-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action

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
config.scrollback_lines = 10000
config.scroll_to_bottom_on_input = true
config.show_update_window = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 30
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = false
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = true
config.window_close_confirmation = 'AlwaysPrompt'
config.window_decorations = "RESIZE"

config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = '#21252b',

		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = '#98c379',
			fg_color = '#21252b',

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = 'Normal',

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = 'None',
			italic = false,
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = '#282c34',
			fg_color = '#808080',
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = '#3b3f4c',
			fg_color = '#909090',
			italic = false,
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = '#21252b',
			fg_color = '#808080',
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = '#3b3f4c',
			fg_color = '#909090',
			italic = true,
		},
	},
}

config.launch_menu = {
	{
		label = 'Neovim Config',
		args = { 'nvim' },
		cwd = "C:\\Users\\Dilip Chauhan\\AppData\\Local\\nvim"
	},
}

config.ssh_domains = {
	{
		-- This name identifies the domain
		name = 'MTAcct',
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = '10.9.0.4',
		-- The username to use on the remote host
		username = 'mfg',
	},
}

config.keys = {
	{ action = action.ActivateCommandPalette		, mods = 'CTRL|SHIFT', key =     'P' },
	{ action = action.CopyTo    'Clipboard' 		, mods = 'CTRL|SHIFT', key =     'C' },
	{ action = action.DecreaseFontSize      		, mods =       'CTRL', key =     '-' },
	{ action = action.IncreaseFontSize      		, mods =       'CTRL', key =     '=' },
	{ action = action.Nop                   		, mods =        'ALT', key = 'Enter' },
	{ action = action.PasteFrom 'Clipboard' 		, mods = 'CTRL|SHIFT', key =     'V' },
	{ action = action.ResetFontSize         		, mods =       'CTRL', key =     '0' },
	{ action = action.ActivateCopyMode         	, mods = 'CTRL|SHIFT', key =     'X' },
	{ action = action.TogglePaneZoomState         , mods = 'CTRL|SHIFT', key =     'Z' },
	{ action = action.ToggleFullScreen      		,                      key =   'F11' },
	{ action = action.SpawnTab "CurrentPaneDomain", mods = 'CTRL|SHIFT', key =	   'T' },
	{ action = action.CloseCurrentTab{confirm=true}, mods = 'CTRL|SHIFT', key =	   'W' },
	{ action = action.ShowLauncher						, mods =			'CTRL', key =		'x' },
	{ action = action.SplitHorizontal {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'|' },
	{ action = action.SplitVertical {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'_' },
	{ action = action.ActivateTabRelative(-1)		, mods =			'CTRL', key = 'Tab' },
	{ action = action.ActivateTabRelative(1)		, mods =			'CTRL|SHIFT', key = 'Tab' },
}

-- and finally, return the configuration to wezterm
return config
