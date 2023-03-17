local Other = {}

function Other.isInArrayJSON(value)
    if not value == nil then
        if value == true then
            return true
        end
        return false
    end
    return false
end

return Other
