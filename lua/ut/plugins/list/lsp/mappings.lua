local M = {}

---@diagnostic disable-next-line: unused-local
function M.on_attach(_client, bufnr)
	local map = vim.keymap.set
	local map_opt = { silent = true, buffer = bufnr }

	local function diagnostic_goto_wrap(forwards, severity)
		local goto_fn = forwards and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
		severity = severity and vim.diagnostic.severity[severity]
		return function()
			goto_fn({ severity = severity })
		end
	end

	-- Hover mappings
	map("n", "K", vim.lsp.buf.hover, map_opt)
	map("n", "<leader>K", vim.lsp.buf.signature_help, map_opt)

	-- Goto symbols mappings
	map("n", "<leader>lr", function() require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown()) end, map_opt)
	map("n", "<leader>ld", function() require("telescope.builtin").lsp_definitions(require("telescope.themes").get_dropdown()) end, map_opt)
	map("n", "<leader>lD", vim.lsp.buf.declaration, map_opt) -- lol
	map("n", "<leader>li", function() require("telescope.builtin").lsp_implementations(require("telescope.themes").get_dropdown()) end, map_opt)
	map("n", "<leader>lt", function() require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_dropdown()) end, map_opt)
	map("n", "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, map_opt)
	map("n", "<leader>ls", function() require("telescope.builtin").lsp_workspace_symbols({ query = vim.fn.input("Find Symbol: ") }) end, map_opt)

	-- Code actions mappings
	map("n", "<leader>ln", vim.lsp.buf.rename,        map_opt)
	map("n", "<leader>lc", vim.diagnostic.open_float, map_opt)
	map("n", "<leader>lC", vim.lsp.buf.code_action,   map_opt)

	-- Goto diagnostics mappings
	map("n", "<leader>lx", function() require("telescope.builtin").diagnostics() end, map_opt)
	map("n", "]d", diagnostic_goto_wrap(true),           map_opt)
	map("n", "[d", diagnostic_goto_wrap(false),          map_opt)
	map("n", "]r", diagnostic_goto_wrap(true,  "ERROR"), map_opt)
	map("n", "[r", diagnostic_goto_wrap(false, "ERROR"), map_opt)
	map("n", "]w", diagnostic_goto_wrap(true,  "WARN"),  map_opt)
	map("n", "[w", diagnostic_goto_wrap(false, "WARN"),  map_opt)
end

return M
