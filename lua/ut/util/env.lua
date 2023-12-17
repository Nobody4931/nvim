local M = {}

---@return string # The operating system Neovim is running on
function M.get_os()
	return vim.loop.os_uname().sysname
end

---@param name string The name of the environment variable to get
---@return string # The value of the environment variable specified
function M.get_var(name)
	return vim.loop.os_getenv(name)
end

---@return boolean # If Neovim is running through a separate GUI frontend
function M.is_gui_nvim()
	return M.is_neovide() or M.is_nvy()
end

---@return boolean # If Neovim is running through Neovide
function M.is_neovide()
	return vim.g.neovide ~= nil
end

---@return boolean # If Neovim is running through Nvy
function M.is_nvy()
	return vim.g.nvy ~= nil
end

return M
