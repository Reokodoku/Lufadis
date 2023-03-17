local http = require("coro-http")
local json = require("json")
local timer = require('timer')
local endpoints = require('endpoints')
local constants = require('constants')
local User = require("classes/User")

local package = require('../package.lua')

local f = string.format

local API = {}
API.__index = API

function API.new(apiVersion)
	local self = setmetatable({}, API)
	self._apiVersion = apiVersion or 10
    self._userAgent = f('DiscordBot (%s, %s)', package.homepage, package.version)
    return self
end

function API:authenticate(token)
	self._token = token
	return User.new(self:getCurrentUser())
end

function API:request(method, endpoint, body)
    local url = f("%s/v%d%s", constants.API, self._apiVersion, endpoint)

    local headers = {
        {'User-Agent', self._userAgent},
		{'Authorization', self._token},
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

function API:postMeChannel(channel_id)
	local endpoint = endpoints.ME_CHANNELS
	return self:request("POST", endpoint, json.encode({recipient_id = channel_id}))
end

function API:postChannelMessage(channel_id, content)
	local endpoint = f(endpoints.CHANNEL_MESSAGES, channel_id)
	return self:request("POST", endpoint, json.encode({content = content}))
end

function API:getCurrentUser()
	local endpoint = endpoints.ME
	return self:request("GET", endpoint)
end

function API:createDM(payload)
	local endpoint = endpoints.ME_CHANNELS
	return self:request("POST", endpoint, payload)
end

function API:getUser(user_id)
	local endpoint = f(endpoints.USER, user_id)
	return self:request("GET", endpoint)
end

function API:getChannel(channel_id)
	local endpoint = f(endpoints.CHANNEL, channel_id)
	return self:request("GET", endpoint)
end

function API:getGuilds()
	local endpoint = endpoints.GUILDS
	return self:request("GET", endpoint)
end

function API:getGuild(guild_id)
	local endpoint = f(endpoints.GUILD, guild_id)
	return self:request("GET", endpoint)
end

function API:getGuildsWebhook(guild_id)
	local endpoint = f(endpoints.GUILD_WEBHOOKS, guild_id)
	return self:request("GET", endpoint)
end

function API:getGuildChannels(guild_id)
	local endpoint = f(endpoints.GUILD_CHANNELS, guild_id)
	return self:request("GET", endpoint)
end

function API:deleteGuild(guild_id)
	local endpoint = f(endpoints.GUILD, guild_id)
	return self:request("DELETE", endpoint)
end

return API