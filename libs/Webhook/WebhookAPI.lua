local http = require("coro-http")
local json = require("json")
local timer = require('timer')
local endpoints = require('endpoints')
local constants = require('constants')

local package = require('../../package.lua')

local WebhookAPI = {
	apiVersion = 10,
	userAgent = string.format('DiscordWebhook (%s, %s)', package.homepage, package.version),
	token = nil,
	new =
		function (self, apiVersion)
			if not apiVersion == nil then
				apiVersion = apiVersion
			end
			return self
		end
}

function WebhookAPI:authenticate(token)
	self.token = token
end

function WebhookAPI:request(method, endpoint, body)
    local url = string.format("%s/v%d%s", constants.API, self.apiVersion, endpoint)

    local headers = {
        {'User-Agent', self.userAgent},
        {'Content-Type', "application/json"},
    }

    local request, data = http.request(method, url, headers, body)

	if request.code == 403 then -- 403 = Forbidden
		return print('Forbidden request attempted. Check client permissions.\n' .. data .. '\n' .. debug.traceback())
	elseif request.code == 401 then -- 401 = Unauthorized
		return print('Unauthorized! Check your client token.\n' .. data .. '\n' .. debug.traceback())
	elseif request.code == 429 then -- 429 = Too many requests
		local delay
		for _, header in ipairs(request) do
			if header[1] == 'Retry-After' then
				delay = header[2]
				break
			end
		end
		print(string.format('Too many requests, retrying in %i ms', delay))
		timer.sleep(delay)
		return self:request(method, endpoint, body)
	elseif request.code == 204 then -- 204 = No Content (usually there is when the user has deleted a content)
		return true
	end

	return json.parse(data)
end

function WebhookAPI:getWebhook(webhook_id)
	return self:request("GET", string.format(endpoints.WEBHOOK_TOKEN, webhook_id, self.token))
end

function WebhookAPI:getWebhookMessage(webhook_id, message_id)
	return self:request("GET", string.format(endpoints.WEBHOOK_TOKEN_MESSAGE, webhook_id, self.token, message_id))
end

function WebhookAPI:deleteWebhookMessage(webhook_id, message_id)
	return self:request("DELETE", string.format(endpoints.WEBHOOK_TOKEN_MESSAGE, webhook_id, self.token, message_id))
end

function WebhookAPI:postWebhook(webhook_id, content)
	return self:request("POST", string.format(endpoints.WEBHOOK_TOKEN, webhook_id, self.token), json.encode(content))
end

function WebhookAPI:deleteWebhook(webhook_id)
	return self:request("DELETE", string.format(endpoints.WEBHOOK_TOKEN, webhook_id, self.token))
end

return WebhookAPI
