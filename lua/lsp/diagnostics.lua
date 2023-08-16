local M = {}

function M:init()
	vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			update_in_insert = true
		}
	)
end

return M
