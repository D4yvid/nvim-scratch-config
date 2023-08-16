local M = {
	buffers = {},

	current_completion_server = nil
}

local Buffer = require 'lsp.buffer'

function M:setup_buffer(buffer, client)
	local buf = Buffer:new(buffer, client)

	self.buffers[buffer] = buf

	vim.api.nvim_create_autocmd('InsertEnter', {
		buffer = buffer,
		callback = function () self:on_insert_enter(buf) end
	})
end

function M:insert_enter()
	-- TODO: Work in the phone for now
end

return M
