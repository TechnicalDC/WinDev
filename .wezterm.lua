---@diagnostic disable: unused-local
-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action
local mux = wezterm.mux
local resize_step = 5
local colors = {
	black = "#181a1f",
	bg0 = "#282c34",
	bg1 = "#31353f",
	bg2 = "#393f4a",
	bg3 = "#3b3f4c",
	bg_d = "#21252b",
	bg_blue = "#73b8f1",
	bg_yellow = "#ebd09c",
	fg = "#abb2bf",
	purple = "#c678dd",
	green = "#98c379",
	orange = "#d19a66",
	blue = "#61afef",
	yellow = "#e5c07b",
	cyan = "#56b6c2",
	red = "#e86671",
	grey = "#5c6370",
	light_grey = "#848b98",
	dark_cyan = "#2b6f77",
	dark_red = "#993939",
	dark_yellow = "#93691d",
	dark_purple = "#8a3fa0",
	diff_add = "#31392b",
	diff_delete = "#382b2c",
	diff_change = "#1c3448",
	diff_text = "#2c5372",
}

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
		title = title:gsub( "\\", " ")
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	title = tab_info.active_pane.title
	title = title:gsub( "\\", " ")
	title = title:gsub( ".exe", "")
	return title
end

wezterm.on( 'format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	local title_icon = {
		cmd = '  ',
		powershell = ' 󰨊 ',
		vim = '  ',
		ssh = ' 󰒋 '
	}
	local title_name = tab_title(tab)
	local title = ""
	for i in string.gmatch(title_name, "%S+") do
		title = i
	end
	-- if title_name:match("Copy") then
	-- 	title = '  ' .. title .. ' '
	-- end
	if title:match("@") then
		title = title_icon['ssh'] .. title .. ' '
	else
		title = title_icon[title] .. title .. ' '
	end
	return title
end)

wezterm.on('update-right-status', function(window, pane)
	local time = wezterm.strftime("%H:%M:%S")
	local stat = window:active_workspace()
	local hostname = wezterm.hostname()
	local battery = ''

	for _, b in ipairs(wezterm.battery_info()) do
		if b.state_of_charge * 100 <= 100 and b.state_of_charge * 100 > 75 then
			battery = '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
		end
		if b.state_of_charge * 100 <= 75 and b.state_of_charge * 100 > 60 then
			battery = '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
		end
		if b.state_of_charge * 100 <= 60 and b.state_of_charge * 100 > 40 then
			battery = '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
		end
		if b.state_of_charge * 100 <= 40 and b.state_of_charge * 100 > 15 then
			battery = '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
		end
		if b.state_of_charge * 100 <= 15 then
			battery = '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
		end

		if b.state == "Charging" then
			battery = battery .. ' '
		end
	end

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Background = { Color = colors.blue } },
		{ Foreground = { Color = colors.bg_d } },
		{ Text = " " },
		{ Text = " " .. stat },
		{ Text = " " },
		"ResetAttributes",
	}))
	-- Make it italic and underlined
	window:set_right_status(wezterm.format {
		{ Background = { Color = colors.blue } },
		{ Foreground = { Color = colors.bg_d } },
		{ Attribute = { Italic = false } },
		{ Text = " " },
		{ Text = battery },
		{ Text = " " },
		{ Text = '  ' .. time .. ' ' },
		"ResetAttributes",
	})
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { 'powershell.exe' }
config.default_cwd = 'C:\\Users\\Dilip Chauhan\\Desktop\\WORK\\'
config.default_domain = "local"
config.default_workspace = "default"

config.font = wezterm.font 'Iosevka NF'
config.font_size = 10
config.default_cursor_style = 'SteadyBlock'
config.line_height = 1.1
config.color_scheme = 'OneDark (base16)'
config.scrollback_lines = 10000
config.detect_password_input = true
config.scroll_to_bottom_on_input = true
config.show_update_window = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 30
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = false
config.adjust_window_size_when_changing_font_size = false
config.force_reverse_video_cursor = false
config.hide_mouse_cursor_when_typing = true
config.window_close_confirmation = 'AlwaysPrompt'
config.window_decorations = "RESIZE"
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.pane_focus_follows_mouse = false
-- config.default_mux_server_domain = "local"
config.skip_close_confirmation_for_processes_named = {
	'bash',
	'sh',
	'zsh',
	'fish',
	'nu',
	'cmd.exe',
	'pwsh.exe',
	'powershell.exe',
}
config.command_palette_font_size = config.font_size
config.command_palette_bg_color = colors.bg_d
config.command_palette_fg_color = colors.fg
config.colors = {
	tab_bar = {
		background = colors.bg_d,

		active_tab = {
			bg_color = colors.green,
			fg_color = colors.bg_d,

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
			bg_color = colors.bg0,
			fg_color = colors.fg,
		},

		inactive_tab_hover = {
			bg_color = colors.bg3,
			fg_color = colors.fg,
			italic = false,
		},

		new_tab = {
			bg_color = colors.bg_d,
			fg_color = colors.fg,
		},

		new_tab_hover = {
			bg_color = colors.bg3,
			fg_color = colors.fg,
			italic = true,
		},
	},
}

-- config.window_padding = {
-- 	left = 2,
-- 	right = 2,
-- 	top = 2,
-- 	bottom = 2,
-- }

config.launch_menu = {
	{
		label = 'Neovim Config',
		args = { 'nvim' },
		cwd = "C:\\Users\\Dilip Chauhan\\AppData\\Local\\nvim"
	},
}

config.ssh_backend = "Ssh2"
config.ssh_domains = wezterm.default_ssh_domains()

-- config.ssh_domains = {
-- 	{
-- 		name = 'POD',
-- 		remote_address = '192.168.22.31',
-- 		ssh_option = {
-- 			identityfile = 'C:\\Users\\Dilip Chauhan\\.ssh\\id_rsa'
-- 		}
-- 	}
-- }

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
	{ action = action.ShowLauncher						, mods =			'CTRL|SHIFT', key =		'A' },
	{ action = action.SplitHorizontal {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'|' },
	{ action = action.SplitVertical {domain="CurrentPaneDomain"}, mods = 'CTRL|SHIFT', key =	'_' },
	{ action = action.ActivateTabRelative(1)		, mods =			'CTRL', key = 'Tab' },
	{ action = action.ActivateTabRelative(-1)		, mods =			'CTRL|SHIFT', key = 'Tab' },
	{ action = action.QuickSelect						, mods =			'CTRL|SHIFT', key = 'Space' },
	{ action = action.ActivateCommandPalette		, mods =			'CTRL|SHIFT', key = ':' },
	{ action = action.AdjustPaneSize { 'Left', resize_step }	, mods =			'CTRL|ALT', key =		'h' },
	{ action = action.AdjustPaneSize { 'Right', resize_step } , mods =		'CTRL|ALT', key =		'l' },
	{ action = action.AdjustPaneSize { 'Down', resize_step }	, mods =			'CTRL|ALT', key =		'j' },
	{ action = action.AdjustPaneSize { 'Up', resize_step }	, mods =			'CTRL|ALT', key =		'k' },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = action.ActivateTab(i - 1)
	})
end

-- and finally, return the configuration to wezterm
return config
