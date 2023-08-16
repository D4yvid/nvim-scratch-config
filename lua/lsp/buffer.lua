local M = {}

function M:new(buffer, client)
	return {
		buffer = buffer,
		client = client,
		requests = {}
	}
end

return M
