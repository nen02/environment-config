-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.color_schemes = {
	["One Dark"] = {
		foreground = "#abb2bf",
		background = "#282c34",
		cursor_bg = "#528bff",
		cursor_border = "#528bff",
		cursor_fg = "#ffffff",
		selection_bg = "#3e4451",
		selection_fg = "#ffffff",

		ansi = { "#282c34", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
		brights = { "#5c6370", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#ffffff" },

		-- Tab bar colors
		tab_bar = {
			background = "#21252b",
			active_tab = {
				bg_color = "#282c34",
				fg_color = "#61afef",
			},
			inactive_tab = {
				bg_color = "#21252b",
				fg_color = "#5c6370",
			},
			inactive_tab_hover = {
				bg_color = "#3e4451",
				fg_color = "#abb2bf",
				italic = true,
			},
			new_tab = {
				bg_color = "#21252b",
				fg_color = "#5c6370",
			},
			new_tab_hover = {
				bg_color = "#3e4451",
				fg_color = "#abb2bf",
				italic = true,
			},
		},
	},
}

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

config.enable_tab_bar = false
config.window_background_opacity = 0.92
config.macos_window_background_blur = 10

-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

config.window_decorations = "RESIZE"

return config
