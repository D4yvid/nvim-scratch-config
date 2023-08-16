local M = {
	running_clients = {},

	servers = {
		{ filetype = 'c', cmd = { 'clangd' } }
	}
}

function M:on_attach(bufnr, client)
	local mappings = require 'mappings'

	mappings:lsp_mappings(bufnr)
end

function M:start_lsp(filetype, opts)
	local cid = self.running_clients[filetype]

	if not self.running_clients[filetype] then
		if not opts.on_attach then
			opts.on_attach = on_attach
		end
		
		opts.name = 'lsp_' .. filetype

		cid = vim.lsp.start_client(opts)

		self.running_clients[filetype] = cid
	end

	vim.lsp.buf_attach_client(0, cid)
end

function M:setup_lsp(opts)
	local filetype = opts.filetype

	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetype,
		callback = function () self:start_lsp(filetype, opts) end
	})
end

function M:init()
	local diagnostics = require 'lsp.diagnostics'

	diagnostics:init()

	for _, server in ipairs(self.servers) do
		self:setup_lsp(server)
	end
end

return M
