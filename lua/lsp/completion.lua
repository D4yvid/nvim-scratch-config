local M = {
	buffers = {},

	current_completion_server = nil
}

local Buffer, BufferState = require 'lsp.buffer'.Buffer, require 'lsp.buffer'.BufferState

function M:setup_buffer(buffer, client)
	local buf = Buffer:new(buffer, client)

	self.buffers[buffer] = buf

	vim.api.nvim_create_autocmd('InsertEnter', {
		buffer = buffer,
		callback = function () self:on_insert_enter(buf) end
	})

	vim.api.nvim_create_autocmd('InsertLeave', {
		buffer = buffer,
		callback = function () self:on_insert_leave(buf) end
	})

	vim.api.nvim_create_autocmd('InsertCharPre', {
		buffer = buffer,
		callback = function () self:on_insert_char(buf) end
	})

	vim.api.nvim_create_autocmd('CompleteDonePre', {
		buffer = buffer,
		callback = function () self:on_complete_done(buf) end
	})
end

function M:on_complete_done(buf)
	buf.state = BufferState.INSERT
end

function M:handle_completion(buf, results)
	if buf.state ~= BufferState.INSERT then
		return
	end

	buf.state = BufferState.COMPLETION
end

function M:on_insert_char(buf)
	vim.notify '[Completion] Inserting character'

	if buf.state == BufferState.COMPLETION then
		return
	end
end

function M:request_completion(buf)
	buf:request_completion(function (results)
		self:handle_completion(buf, results)
	end)
end

function M:on_insert_leave(buf)
	buf.state = BufferState.NORMAL
end

function M:on_insert_enter(buf)
	buf.state = BufferState.INSERT
end

return M
