---@diagnostic disable: unused-local
-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on( 'format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	return ' ' .. title .. ' '
end)

-- wezterm.on('update-right-status', function(window, pane)
-- 	local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'
--
-- 	-- Make it italic and underlined
-- 	window:set_right_status(wezterm.format {
-- 		{ Attribute = { Underline = 'Single' } },
-- 		{ Attribute = { Italic = false } },
-- 		{ Text = 'Hello ' .. date },
-- 	})
-- end)

-- This table will hold the configuration.
local config = {}
local resize_step = 5

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { 'powershell.exe' }
config.default_cwd = 'C:\\Users\\Dilip Chauhan\\Desktop\\WORK\\'

config.font = wezterm.font 'Iosevka NF'
config.font_size = 10
config.line_height = 1.1
config.color_scheme = 'OneDark (base16)'
config.scrollback_lines = 10000
config.scroll_to_bottom_on_input = true
config.show_update_window = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 30
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = false
config.adjust_window_size_when_changing_font_size = false
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = true
config.window_close_confirmation = 'AlwaysPrompt'
config.window_decorations = "RESIZE"
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.skip_close_confirmation_for_processes_named = {
	'bash',
	'sh',
	'zsh',
	'fish',
	'tmux',
	'nu',
	'cmd.exe',
	'pwsh.exe',
	'powershell.exe',
}

config.colors = {
	tab_bar = {
		background = '#21252b',

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

		inactive_tab = {
			bg_color = '#282c34',
			fg_color = '#808080',
		},

		inactive_tab_hover = {
			bg_color = '#3b3f4c',
			fg_color = '#909090',
			italic = false,
		},

		new_tab = {
			bg_color = '#21252b',
			fg_color = '#808080',
		},

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
		remote_address = '10.9.0.4',
		username = 'mfg',
		ssh_option = {
			identityfile = 'C:\\Users\\Dilip Chauhan\\.ssh\\id_rsa.pub',
		},
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
	{ action = action.CloseCurrentPane{confirm=true}, mods = 'CTRL|SHIFT', key =	   'Q' },
	{ action = action.ShowLauncher						, mods =			'CTRL|ALT', key =		'x' },
	{ action = action.SplitHorizontal {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'|' },
	{ action = action.SplitVertical {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'_' },
	{ action = action.ActivateTabRelative(1)		, mods =			'CTRL', key = 'Tab' },
	{ action = action.ActivateTabRelative(-1)		, mods =			'CTRL|SHIFT', key = 'Tab' },
	-- { action = action.QuickSelect						, mods =			'CTRL|SHIFT', key = 'Space' },
	-- { action = action.ActivateCommandPalette		, mods =			'CTRL|SHIFT', key = ':' }
	{ action = action.AdjustPaneSize { 'Left', resize_step }	, mods =			'CTRL|ALT', key =		'h' },
	{ action = action.AdjustPaneSize { 'Right', resize_step } , mods =		'CTRL|ALT', key =		'l' },
	{ action = action.AdjustPaneSize { 'Down', resize_step }	, mods =			'CTRL|ALT', key =		'j' },
	{ action = action.AdjustPaneSize { 'Up', resize_step }	, mods =			'CTRL|ALT', key =		'k' },
}

-- and finally, return the configuration to wezterm
return config
