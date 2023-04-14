local M = {}

---@type string
M.colorscheme = require("ut.util.env").is_gui_nvim()
	and "catppuccin"
	or "tokyonight"

return M
