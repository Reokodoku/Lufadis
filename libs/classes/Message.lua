local Snowflake = require("classes/Snowflake")

local Message = {}
Message.__index = Message

function Message.new(data)
	local self = setmetatable({}, Message)

    self._data = data or {}

    self.id = self._data.id
    self.type = self._data.type
    self.content = self._data.content
    self.author = self._data.author
    self.channelId = self._data.channel_id
    self.attachments = self._data.attachments
    self.embeds = self._data.embeds
    self.mentions = self._data.mentions
    self.mentionRoles = self._data.mention_roles
    self.mentionEveryone = self._data.mention_everyone
    self.tts = self._data.tts
    self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake:convertToTimestamp(self.id))
    self.createdTimestamp = Snowflake:convertToTimestamp(self.id)
    self.pinned = self._data.pinned
    self.components = self._data.components
    self.flags = self._data.flags
    self.webhookId = (self._data.webhook_id == nil and nil or self._data.webhook_id)

    return self
end

function Message:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake:convertToTimestamp(self.id))
end

return Message