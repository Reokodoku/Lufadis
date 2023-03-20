local http = require('coro-http')
local json = require('json')
local timer = require('timer')
local endpoints = require('endpoints')
local constants = require('constants')
local User = require('classes/User')

local package = require('../package.lua')

local API = {
	apiVersion = 10,
	userAgent = string.format('DiscordBot (%s, %s)', package.homepage, package.version),
	token = nil,
	new =
		function (self, apiVersion)
			if apiVersion ~= nil then
				apiVersion = apiVersion
			end
			return self
		end,
	get =
		function (self)
			return self
		end
}

function API:authenticate(token)
	self.token = token
	return User.new(self:getCurrentUser())
end

function API:request(method, endpoint, body)
    local url = string.format("%s/v%d%s", constants.API, self._apiVersion, endpoint)

    local headers = {
        {'User-Agent', self.userAgent},
		{'Authorization', self.token},
        {'Content-Type', "application/json"},
    }

    local request, data = http.request(method, url, headers, body)

	if request.code == 400 then -- 400 = Bad request
		return print('Bad request attempted. Error: ' .. data)
	elseif request.code == 403 then -- 403 = Forbidden
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

function API:postMeChannel(channel_id)
	return self:request("POST", endpoints.ME_CHANNELS, json.encode( { recipient_id = channel_id } ))
end

function API:postChannelMessage(channel_id, content)
	return self:request("POST", string.format(endpoints.CHANNEL_MESSAGES, channel_id), json.encode( { content = content } ))
end

function API:getCurrentUser()
	return self:request("GET", endpoints.ME)
end

function API:createDM(payload)
	return self:request("POST", endpoints.ME_CHANNELS, payload)
end

function API:getUser(user_id)
	return self:request("GET", string.format(endpoints.USER, user_id))
end

function API:getChannel(channel_id)
	return self:request("GET", string.format(endpoints.CHANNEL, channel_id))
end

function API:getGuilds()
	return self:request("GET", endpoints.GUILDS)
end

function API:getGuild(guild_id)
	return self:request("GET", string.format(endpoints.GUILD, guild_id))
end

function API:getGuildsWebhook(guild_id)
	return self:request("GET", string.format(endpoints.GUILD_WEBHOOKS, guild_id))
end

function API:getGuildChannels(guild_id)
	return self:request("GET", string.format(endpoints.GUILD_CHANNELS, guild_id))
end

function API:deleteGuild(guild_id)
	return self:request("DELETE", string.format(endpoints.GUILD, guild_id))
end

return API
