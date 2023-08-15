local running_clients = {}

local function on_attach(bufnr, client)
	local map = function (m, k, f) vim.keymap.set(m, k, f, { noremap = true, silent = true }) end
	local nmap = function (k, f) map('n', k, f) end
	local imap = function (k, f) map('i', k, f) end

	vim.g.mapleader = ' '

	nmap('gD', vim.lsp.buf.declaration)
	nmap('gi', vim.lsp.buf.implementation)
	nmap('gr', vim.lsp.buf.references)
	nmap('K', vim.lsp.buf.hover)
	nmap('<leader><leader>', vim.lsp.buf.code_action)
	nmap('<leader>f', vim.lsp.buf.format)
end

local function start_lsp(filetype, opts)
	local cid = running_clients[filetype]

	if not running_clients[filetype] then
		if not opts.on_attach then
			opts.on_attach = on_attach
		end
		
		opts.name = 'lsp_' .. filetype

		cid = vim.lsp.start_client(opts)

		running_clients[filetype] = cid
	end

	vim.lsp.buf_attach_client(0, cid)
end

local function setup_lsp(opts)
	local filetype = opts.filetype

	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetype,
		callback = function () start_lsp(filetype, opts) end
	})
end

setup_lsp {
	filetype = 'c',
	cmd = { 'clangd' }
}
