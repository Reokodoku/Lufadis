local http = require("coro-http")
local json = require("json")
local timer = require('timer')
local endpoints = require('endpoints')
local constants = require('constants')

local package = require('../../package.lua')

local f = string.format

local WebhookAPI = {}
WebhookAPI.__index = WebhookAPI

function WebhookAPI.new(apiVersion)
	local self = setmetatable({}, WebhookAPI)
	self._apiVersion = apiVersion or 10
    self._userAgent = f('DiscordWebhook (%s, %s)', package.homepage, package.version)
    return self
end

function WebhookAPI:authenticate(token)
	self._token = token
end

function WebhookAPI:request(method, endpoint, body)
    local url = f("%s/v%d%s", constants.API, self._apiVersion, endpoint)

    local headers = {
        {'User-Agent', self._userAgent},
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
		print(f('Too many requests, retrying in %i ms', delay))
		timer.sleep(delay)
		return self:request(method, endpoint, body)
	elseif request.code == 204 then -- 204 = No Content (usually there is when the user has deleted a content)
		return true
	end

	return json.parse(data)
end

function WebhookAPI:getWebhook(webhook_id)
	local endpoint = f(endpoints.WEBHOOK_TOKEN, webhook_id, self._token)
	return self:request("GET", endpoint)
end

function WebhookAPI:getWebhookMessage(webhook_id, message_id)
	local endpoint = f(endpoints.WEBHOOK_TOKEN_MESSAGE, webhook_id, self._token, message_id)
	return self:request("GET", endpoint)
end

function WebhookAPI:postWebhook(webhook_id, content)
	local endpoint = f(endpoints.WEBHOOK_TOKEN, webhook_id, self._token)
	return self:request("POST", endpoint, json.encode(content))
end

return WebhookAPI