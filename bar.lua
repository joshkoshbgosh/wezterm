local wezterm = require("wezterm")
local bar = require("plugins/wezterm-bar")
local command_icons = require("utils/command-icons")

local M = {}

command_icons = {
	["psql"] = "󱤢",
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["node"] = wezterm.nerdfonts.mde_nodejs,
	["go"] = wezterm.nerdfonts.seti_go,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["fish"] = wezterm.nerdfonts.md_fish,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["git"] = wezterm.nerdfonts.dev_git,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
}

local function apply_right_status()
	wezterm.on("update-status", function(window, pane)
		local workspace = window:active_workspace()

		local basename = function(s)
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end
		local cwd = pane:get_current_working_dir()
		cwd = cwd and basename(cwd) or ""

		local cmd = pane:get_foreground_process_name()
		cmd = cmd and basename(cmd) or ""
		local cmd_icon = command_icons[cmd] ~= nil and command_icons[cmd] or wezterm.nerdfonts.dev_terminal

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "#f38ba8" } },
			{ Text = wezterm.nerdfonts.cod_terminal_tmux .. " " .. workspace },
			"ResetAttributes",
			{ Text = " | " },
			{ Foreground = { Color = "#94e2d5" } },
			{ Text = wezterm.nerdfonts.md_folder .. " " .. cwd },
			"ResetAttributes",
			{ Text = " | " },
			{ Foreground = { Color = "#89b4fa" } },
			{ Text = cmd_icon .. " " .. cmd },
			"ResetAttributes",
			{ Text = "  " },
		}))
	end)
end

M.apply_to_config = function(config)
	-- Tab bar colour changes
	config.colors.tab_bar = {
		background = "#181825",
		inactive_tab = {
			fg_color = "#a6adc8",
			bg_color = "#181825",
		},
	}

	bar.apply_base_bar(config)
	apply_right_status()
end

return M
