local json = require('json')
local stringUtil = require('utils/string')

local Embed = {
    data = nil
}
Embed.__index = Embed

function Embed.new()
    local self = setmetatable({}, Embed)
    self.data = {
        title = nil,
        type = nil,
        description = nil,
        url = nil,
        timestamp = nil,
        color = nil,
        hexColor = nil,
        footer = nil,
        image = nil,
        thumbnail = nil,
        video = nil,
        provider = nil,
        author = nil,
        fields = nil,
    }
    return self
end

function Embed.fromTable(table)
    local self = setmetatable({}, Embed)
    self.data = {
        title = table.title,
        type = table.type,
        description = table.description,
        url = table.url,
        timestamp = table.timestamp,
        color = table.color,
        hexColor = table.hexColor,
        footer = table.footer,
        image = table.image,
        thumbnail = table.thumbnail,
        video = table.video,
        provider = table.provider,
        author = table.author,
        fields = table.fields,
    }
    return self
end

function Embed.fromJSON(jsonData)
    local self = setmetatable({}, Embed)
    local table = json.parse(jsonData)
    self.data = {
        title = table.title,
        type = table.type,
        description = table.description,
        url = table.url,
        timestamp = table.timestamp,
        color = table.color,
        hexColor = table.hexColor,
        footer = table.footer,
        image = table.image,
        thumbnail = table.thumbnail,
        video = table.video,
        provider = table.provider,
        author = table.author,
        fields = table.fields,
    }
    return self
end

function Embed:toJSON()
    return json.stringify({
        title = self.data.title,
        type = self.data.type,
        description = self.data.description,
        url = self.data.url,
        timestamp = self.data.timestamp,
        color = self.data.color,
        hexColor = self.data.color,
        footer = self.data.footer,
        image = self.data.image,
        thumbnail = self.data.thumbnail,
        video = self.data.video,
        provider = self.data.provider,
        author = self.data.author,
        fields = self.data.fields,
    })
end

function Embed:equals(other)
    return {
        title = self.data.title,
        type = self.data.type,
        description = self.data.description,
        url = self.data.url,
        timestamp = self.data.timestamp,
        color = self.data.color,
        hexColor = self.data.color,
        footer = self.data.footer,
        image = self.data.image,
        thumbnail = self.data.thumbnail,
        video = self.data.video,
        provider = self.data.provider,
        author = self.data.author,
        fields = self.data.fields,
    } == {
        title = other.title,
        type = other.type,
        description = other.description,
        url = other.url,
        timestamp = other.timestamp,
        color = other.color,
        hexColor = other.color,
        footer = other.footer,
        image = other.image,
        thumbnail = other.thumbnail,
        video = other.video,
        provider = other.provider,
        author = other.author,
        fields = other.fields,
    }
end

---Return 'true' if the embed is valid while return 'false' if the embed isn't valid.
---@return boolean
function Embed:validate()
    if self.data.title ~= nil and string.len(stringUtil.removeLeadingTrailingWhitespaces(self.data.title)) > 256 then
        return false
    end

    if self.data.description ~= nil and string.len(stringUtil.removeLeadingTrailingWhitespaces(self.data.description)) > 4096 then
        return false
    end

    if self.data.fields ~= nil and #self.data.fields > 25 then
        return false
    end

    if self.data.fields ~= nil then
        for i,field in ipairs(self.data.fields) do
            if string.len(stringUtil.removeLeadingTrailingWhitespaces(field.name)) > 256 then
                return false
            end

            if string.len(stringUtil.removeLeadingTrailingWhitespaces(field.value)) > 1024 then
                return false
            end
        end
    end

    if self.data.footer ~= nil and string.len(stringUtil.removeLeadingTrailingWhitespaces(self.data.footer.text)) > 2048 then
        return false
    end

    if self.data.author ~= nil and string.len(stringUtil.removeLeadingTrailingWhitespaces(self.data.author.name)) > 256 then
        return false
    end

    return true
end

return Embed
