local http = require("coro-http")
local json = require("json")
local Snowflake = require("classes/Snowflake")
local Message = require("classes/Message")
local CDN = require("CDN")
local WebhookAPI = require("Webhook/WebhookAPI")
local WebhookTypes = require('enums/WebhookTypes')

local Webhook = {
    api = nil,
    type = nil,
    id = nil,
    name = nil,
    token = nil,
    avatar = nil,
    channelId = nil,
    createdAt = nil,
    createdTimestamp = nil,
    guildId = nil,
    owner = nil,
    sourceChannel = nil,
    sourceGuild = nil,
    url = nil,
    applicationId = nil
}
Webhook.__index = Webhook

function Webhook.new(webhookURL)
    local self = setmetatable({}, Webhook)
    self.api = WebhookAPI.new()
    local request, data = http.request("GET", webhookURL, { {'User-Agent', "DiscordWebhook (https://discord.com/Reokodoku/Lufadis)"}, {'Content-Type', "application/json"} } )
    data = json.parse(data)

    self.applicationId = data.applicationId
    self.type = data.type
    self.id = data.id
    self.name = data.name
    self.token = data.token
    -- Avatar's hash
    self.avatar = data.avatar
    self.channelId = data.channel_id
    self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake.convertToTimestamp(self.id))
    self.createdTimestamp = Snowflake.convertToTimestamp(self.id)
    self.guildId = data.guild_id
    self.owner = (data.owner == nil and nil or data.owner)
    self.sourceChannel = (data.source_channel == nil and nil or data.source_channel)
    self.sourceGuild = (data.source_guild == nil and nil or data.source_guild)
    self.url = webhookURL
    WebhookAPI:authenticate(self.token)
    return self
end

function Webhook:isApplicationCreated()
    return self.type == WebhookTypes.Application
end

function Webhook:isChannelFollower()
    return self.type == WebhookTypes.ChannelFollower
end

function Webhook:isIncoming()
    return self.type == WebhookTypes.Incoming
end

function Webhook:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake.convertToTimestamp(self.id))
end

function Webhook:avatarURL(options)
    return CDN.avatar(self.id, self.avatar, options)
end

function Webhook:send(content)
    if type(content) == "string" then
        content = { content = content }
    end
    return self.api:postWebhook(self.id, content)
end

function Webhook:fetchMessage(message_id)
    return Message.new(self.api:getWebhookMessage(self.id, message_id))
end

function Webhook:deleteMessage(message_id)
    return Message.new(self.api:deleteMessage(self.id, message_id))
end

function Webhook:delete()
    return Message.new(self.api:deleteWebhook(self.id))
end

return Webhook
