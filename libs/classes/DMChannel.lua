local constants = require("constants")

local DMChannel = {}

function DMChannel.send(id, content)
    local dm = constants.api:postMeChannel(id)
    constants.api:postChannelMessage(dm.id, content)
end

return DMChannel
