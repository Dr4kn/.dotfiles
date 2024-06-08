local wezterm = require 'wezterm'
local config = {}

config.enable_scroll_bar = true

config.color_scheme = 'Dracula (Official)'
config.font = wezterm.font 'Comic Code'
config.font_size = 12

-- config.color_scheme = 'Doom Peacock'
config.window_background_opacity = .96

-- dimms inactive panels
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 0.80,
}

-- removes title bar and moves the buttons into the the tab bar
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.keys = {
    -- MAC specific:
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key="LeftArrow", 
        mods="OPT", 
        action=wezterm.action{SendString="\x1bb"}
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key="RightArrow", 
        mods="OPT", 
        action=wezterm.action{SendString="\x1bf"}
    },
    -- same for ctrl + arrow keys
    {
        key="LeftArrow", 
        mods="CTRL", 
        action=wezterm.action{SendString="\x1bb"}
    },
    {
        key="RightArrow", 
        mods="CTRL", 
        action=wezterm.action{SendString="\x1bf"}
    },
}

local function enable_wayland()
	local wayland = os.getenv("XDG_SESSION_TYPE")
	if wayland == "wayland" then
		return true
	end
	return false
end

config.enable_wayland = enable_wayland()

return config
