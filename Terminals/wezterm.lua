-- https://wezfurlong.org/wezterm/config/files.html
local wezterm = require("wezterm")

local padding = 7

return {
    default_prog = { "/usr/sbin/zsh", "--login", "-c", "tmux" },

    window_padding = {
        left = padding,
        right = padding,
        top = padding,
        bottom = padding,
    },
    font = wezterm.font_with_fallback({ "FiraCode Nerd Font" }),
    font_size = 14.0,
    color_scheme = "Ubuntu",
    hide_tab_bar_if_only_one_tab = true,

    -- pane settings
    inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
}
