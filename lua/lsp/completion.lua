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

function M:handle_completion(results)
	vim.notify("Completion results: " .. #vim.inspect(results.items))
end

function M:on_insert_enter(buf)
	buf:request_completion(function (results)
		self:handle_completion(results)
	end)
end

return M
