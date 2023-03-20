local API = require("API")

local DMChannel = {}

function DMChannel.send(id, content)
    local dm = API:get():postMeChannel(id)
    API:get():postChannelMessage(dm.id, content)
end

return DMChannel
