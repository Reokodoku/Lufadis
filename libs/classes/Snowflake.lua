local constants = require("constants")

local Snowflake = {}

function Snowflake.convertToTimestamp(number)
    return (number / 2^22 + constants.DISCORD_EPOCH) / constants.MILLISECONDS_PER_SECOND
end

return Snowflake
