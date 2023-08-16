-- TAB-related
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Spell checking
vim.opt.spell = true

-- Visual-related
vim.cmd.colorscheme 'slate'
vim.opt.showmode = false

vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.fillchars = { eob = ' ' }

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16

vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.wrap = false

vim.opt.updatetime = 200

vim.api.nvim_set_hl(0, 'Visual', { bg = 'none', fg = 'none', sp = 'none', reverse = true })

-- Completion-related
vim.opt.completeopt = 'menu,menuone,noselect,noinsert'

-- Netrw-related
vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_fastbrowse = 2
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 3

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

