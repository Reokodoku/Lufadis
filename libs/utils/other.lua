local Other = {}
Other.__index = Other

function Other:isInArrayJSON(value)
    if value == nil then
        return false
    else
        if value == true then
            return true
        else
            return false
        end
    end
end

return Other