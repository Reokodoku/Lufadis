local json = require('json')
local Embed = require('structures/Embed')

local EmbedBuilder = {
    data = nil,
    new =
        function (self)
            self.data = Embed:new()
            return self
        end
}

function EmbedBuilder:setType(type)
    self.data.type = type
    return self
end

function EmbedBuilder:setTitle(title)
    self.data.title = title
    return self
end

function EmbedBuilder:setDescription(description)
    self.data.description = description
    return self
end

---@param fields table Ex. { { name = "...", value = "...", inline = false/true }, ... } The 'inline' value can be omitted and by default is 'false'.
function EmbedBuilder:setFields(fields)
    self.data.fields = fields
    return self
end

---@param ... table Ex. { name = "...", value = "...", inline = false/true }, ... The 'inline' value can be omitted and by default is 'false'.
function EmbedBuilder:addFields(...)
    for i,v in ipairs({...}) do
        table.insert(self.data.fields, v)
    end
    return self
end

function EmbedBuilder:setURL(url)
    self.data.url = url
    return self
end

function EmbedBuilder:setImage(url)
    self.data.image = url
    return self
end

function EmbedBuilder:setThumbnail(url)
    self.data.thumbnail = url
    return self
end

function EmbedBuilder:toJSON()
    return json.stringify(self.data)
end

return EmbedBuilder
