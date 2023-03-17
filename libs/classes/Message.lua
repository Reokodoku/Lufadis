local Snowflake = require("classes/Snowflake")

local Message = {
    id = nil,
    type = nil,
    content = nil,
    author = nil,
    channelId = nil,
    attachments = nil,
    embeds = nil,
    mentions = nil,
    mentionRoles = nil,
    mentionEveryone = nil,
    tts = nil,
    createdAt = nil,
    createdTimestamp = nil,
    pinned = nil,
    compontents = nil,
    flags = nil,
    webhookId = nil,
    new =
        function (self, data)
            self.id = data.id
            self.type = data.type
            self.content = data.content
            self.author = data.author
            self.channelId = data.channel_id
            self.attachments = data.attachments
            self.embeds = data.embeds
            self.mentions = data.mentions
            self.mentionRoles = data.mention_roles
            self.mentionEveryone = data.mention_everyone
            self.tts = data.tts
            self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake.convertToTimestamp(self.id))
            self.createdTimestamp = Snowflake.convertToTimestamp(self.id)
            self.pinned = data.pinned
            self.components = data.components
            self.flags = data.flags
            self.webhookId = (data.webhook_id == nil and nil or data.webhook_id)
            return self
        end
}

function Message:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake.convertToTimestamp(self.id))
end

return Message
