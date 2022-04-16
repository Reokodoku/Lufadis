local http = require("coro-http")
local json = require("json")
local Snowflake = require("classes/Snowflake")
local getURLs = require("utils/getURLs")
local WebhookAPI = require("Webhook/WebhookAPI")

local f = string.format

local Webhook = {}
Webhook.__index = Webhook

local api = WebhookAPI.new()

function Webhook.new(webhookURL)
	local self = setmetatable({}, Webhook)

    local request, data = http.request("GET", webhookURL, {{'User-Agent', "DiscordWebhook (https://discord.com/Reokodoku/Lufadis)"}, {'Content-Type', "application/json"},})
	data = json.parse(data)

    self._data = data or {}

    self.type = self._data.type
    self.id = self._data.id
    self.name = self._data.name
    self.token = self._data.token
    -- Avatar's hash
    self.avatar = self._data.avatar
    self.channelId = self._data.channel_id
    self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake:convertToTimestamp(self.id))
    self.createdTimestamp = Snowflake:convertToTimestamp(self.id)
    self.guildId = self._data.guild_id
    self.owner = (self._data.owner == nil and nil or self._data.owner)
    self.sourceChannel = (self._data.source_channel == nil and nil or self._data.source_channel)
    self.sourceGuild = (self._data.source_guild == nil and nil or self._data.source_guild)
    self.url = webhookURL

    WebhookAPI:authenticate(self.token)

    return self
end

function Webhook:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake:convertToTimestamp(self.id))
end

function Webhook:avatarURL(options)
    return getURLs.avatar(self.id, self.avatar, options)
end

function Webhook:send(content)
    return api:postWebhook(self.id, content)
end

return Webhook