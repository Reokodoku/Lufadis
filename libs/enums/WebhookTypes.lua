local enum = require('structures/enum')

local WebhookTypes = enum:new {
    Incoming = 1,
    ChannelFollower = 2,
    Application = 3,
}

return WebhookTypes
