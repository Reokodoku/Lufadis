local enum = {
    new =
        function (self, table)
            return table
        end
}

function enum.find(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
    return nil
end

return enum
