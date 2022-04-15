local json = require("json")

local DMChannel = {}
DMChannel.__index = DMChannel

function DMChannel.send(api, id, content)
    local dm = api:postMeChannel(id)
    api:postChannelMessage(dm.id, content)
end

return DMChannel