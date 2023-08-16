local M = {}

local function open_netrw()
	local winlist = vim.fn.win_findbuf(vim.fn.bufnr("NetrwTreeListing"))

	if #winlist > 0 then
		return vim.fn.win_gotoid(winlist[1])
	end

	vim.cmd [[
		vsp
		Ntree
		vert res 35
	]]
end

function M:init()
	-- Mappings
	local map = function (m, k, f) vim.keymap.set(m, k, f, { noremap = true, silent = true }) end
	local nmap = function (k, f) map('n', k, f) end
	local imap = function (k, f) map('i', k, f) end

	vim.g.mapleader = ' '

	nmap('<leader>e', open_netrw)

	vim.cmd [[
		imap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
		imap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
		imap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"
		imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
		imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
		imap <expr><C-Space> !pumvisible() ? "\<C-x>\<C-o>" : "\<C-Space>"
		imap jk <ESC>
	]]
end

function M:lsp_mappings(bufnr)
	local map = function (m, k, f) vim.keymap.set(m, k, f, { noremap = true, silent = true, buffer = bufnr }) end
	local nmap = function (k, f) map('n', k, f) end
	local imap = function (k, f) map('i', k, f) end

	nmap('gD', vim.lsp.buf.declaration)
	nmap('gi', vim.lsp.buf.implementation)
	nmap('gr', vim.lsp.buf.references)
	nmap('K', vim.lsp.buf.hover)
	nmap('<leader><leader>', vim.lsp.buf.code_action)
	nmap('<leader>f', vim.lsp.buf.format)

	imap('<C-s>', vim.lsp.buf.signature_help)
end

return M
