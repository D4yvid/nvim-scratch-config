local M = {
	running_clients = {},

	servers = {
		{ filetype = 'c', cmd = { 'clangd' } }
	}
}

function M.on_attach(client, buffer)
	local mappings = require 'mappings'
	local completion = require 'lsp.completion'

	completion:setup_buffer(buffer, client)
	mappings:lsp_mappings(buffer)
end

function M:start_lsp(filetype, opts)
	local buffer = vim.fn.bufnr("%")
	local cid = self.running_clients[filetype]

	if not cid then
		opts.on_attach = self.on_attach
		opts.name = 'lsp_' .. filetype

		cid = vim.lsp.start_client(opts)

		self.running_clients[filetype] = cid
	end

	vim.lsp.buf_attach_client(buffer, cid)
end

function M:setup_lsp(opts)
	local filetype = opts.filetype

	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetype,
		callback = function ()
			self:start_lsp(filetype, opts)
		end
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
