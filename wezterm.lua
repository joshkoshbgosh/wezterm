local wezterm = require("wezterm")

local bar = require("bar")
local k = require("keymaps")

local config = {}
config = wezterm.config_builder()

-- Colours
config.color_scheme = "Catppuccin Mocha"
config.colors = {}

-- Font
config.font = wezterm.font({
	family = "FiraCode Nerd Font",
})
config.font_size = 15.0
config.line_height = 1.1

-- Window
config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0.5cell",
	bottom = "0cell",
}
config.window_close_confirmation = "AlwaysPrompt"
config.dpi = 144

-- Tabs
config.scrollback_lines = 3500

-- Tab bar
config.use_fancy_tab_bar = false
bar.apply_to_config(config)

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.key_tables = k.key_tables
config.keys = k.keys

return config
