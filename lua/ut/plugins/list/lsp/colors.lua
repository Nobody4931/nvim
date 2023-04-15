local M = {}

---@diagnostic disable-next-line: unused-local
function M.on_attach(client, _bufnr)
	-- Disable LSP semantic highlighting
	client.server_capabilities["semanticTokensProvider"] = nil
end

return M
