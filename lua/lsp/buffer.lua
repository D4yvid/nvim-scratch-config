local BufferState = { NORMAL = 0, COMPLETION = 1, INSERT = 2 }
local Buffer = {}

function Buffer:new(buffer, client)
	local self = setmetatable({}, { __index = Buffer })

	self.buffer = buffer
	self.client = client
	self.state = BufferState.NORMAL
	self.requests = {}

	return self
end

function Buffer:request_completion(callback)
	local params = vim.lsp.util.make_position_params(0, self.client.offset_encoding)

	self:make_request('textDocument/completion', params, function (result)
		callback(result)
	end)
end

function Buffer:make_request(method, params, callback)
	-- heavily inspired on cmp_nvim_lsp

	if self.requests[method] ~= nil then
		self.client.cancel_request(self.requests[method])

		self.requests[method] = nil
	end

	local _, request_id = self.client.request(method, params, function (err, result, ctx)
		if self.requests[method] ~= request_id then return end
		self.requests[method] = nil

		if err then
			if err.code == -32801 then
				-- The LSP server knew that the text changed, so we re-send the request again
				self:make_request(method, params, callback)
				return
			end

			return
		end

		if result == method then
			-- Using old signature
			callback(ctx)
		else
			callback(result)
		end
	end)
end

return { Buffer = Buffer, BufferState = BufferState }
