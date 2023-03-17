local enum = require('structures/enum')

---Embed types should be considered deprecated and might be removed in a future Discord's API version.
---More information at: https://discord.com/developers/docs/resources/channel#embed-object-embed-types
local EmbedTypes = enum:new {
    Article = "article",
    Image = "image",
    Video = "video",
    Link = "link",
    GIFV = "gifv",
    Rich = "rich",
    ---This embed type currently is not documented by Discord.
    ---More information at: https://discord-api-types.dev/api/discord-api-types-v10/enum/EmbedType
    AutoModerationMessage = "auto_moderation_message",
}

return EmbedTypes
