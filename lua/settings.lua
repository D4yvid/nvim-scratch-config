local M = {
	opts = {
		-- TAB-related
		tabstop = 4,
		softtabstop = 4,
		shiftwidth = 4,
		smarttab = true,
		autoindent = true,
		smartindent = true,

		-- Spell checking
		spell = true,

		-- Visual-related
		showmode = false,

		number = true,
		signcolumn = 'yes',
		fillchars = { eob = ' ' },

		scrolloff = 8,
		sidescrolloff = 16,

		colorcolumn = '120',
		cursorline = true,
		wrap = false,

		updatetime = 200,

		-- Completion-related
		completeopt = 'menu,menuone,noselect,noinsert',
	},
	colorscheme = 'slate'
}

function M:init()
	vim.cmd.colorscheme(self.colorscheme)

	for k, v in pairs(self.opts) do
		vim.opt[k] = v
	end

	vim.api.nvim_set_hl(0, 'Visual', { bg = 'none', fg = 'none', sp = 'none', reverse = true })

	-- Netrw-related
	vim.g.netrw_browse_split = 4
	vim.g.netrw_banner = 0
	vim.g.netrw_liststyle = 3
end

return M
