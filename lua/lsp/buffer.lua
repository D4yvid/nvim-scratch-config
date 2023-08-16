local M = {}

function M:new(buffer, client)
	local self = setmetatable({}, { __index = M })

	self.buffer = buffer
	self.client = client
	self.requests = {}

	return self
end

function M:request_completion(callback)
	-- Inspired in cmp_nvim_lsp

	if self.requests.completion ~= nil then
		self.client.cancel_request(self.requests.completion)

		self.requests.completion = nil
	end

	local _, req_id = self:run_request()
end

return M
