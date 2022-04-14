local endpoints = require("endpoints")
local json = require("json")

local f = string.format

local DMChannel = {}
DMChannel.__index = DMChannel

function DMChannel.send(api, id, content)
    local dm = api:request("POST", endpoints.ME_CHANNELS, f('{"recipient_id": %s}', id))
    api:request("POST", f(endpoints.CHANNEL_MESSAGES, dm.id), json.encode({content = content}))
end

return DMChannel