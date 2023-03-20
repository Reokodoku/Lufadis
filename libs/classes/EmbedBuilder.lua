local json = require('json')
local Embed = require('structures/Embed')

local EmbedBuilder = {
    embed = nil
}
EmbedBuilder.__index = EmbedBuilder

function EmbedBuilder.new()
    local self = setmetatable({}, EmbedBuilder)
    self.embed = Embed:new().data
    return self
end

---@deprecated Embed types should be considered deprecated and might be removed in a future Discord's API version. More information at: https://discord.com/developers/docs/resources/channel#embed-object-embed-types
function EmbedBuilder:setType(type)
    self.embed.type = type
    return self
end

function EmbedBuilder:setTitle(title)
    self.embed.title = title
    return self
end

function EmbedBuilder:setDescription(description)
    self.embed.description = description
    return self
end

---@param color integer Ex. 0xFF0000 for red
function EmbedBuilder:setColor(color)
    self.embed.color = color
    return self
end

---@param author table Ex. { name = "...", url = "...", iconURL = "...", proxyIconURL = "..." } The 'url', 'iconURL' and 'proxyIconURL' can be omitted.
function EmbedBuilder:setAuthor(author)
    self.embed.author = { name = author.name, url = author.url, icon_url = author.iconURL, proxy_icon_url = author.proxyIconURL }
    return self
end

---@param fields table Ex. { { name = "...", value = "...", inline = false/true }, ... } The 'inline' value can be omitted and by default is 'false'.
function EmbedBuilder:setFields(fields)
    self.embed.fields = fields
    return self
end

---@param ... table Ex. { name = "...", value = "...", inline = false/true }, ... The 'inline' value can be omitted and by default is 'false'.
function EmbedBuilder:addFields(...)
    for i,field in ipairs({...}) do
        table.insert(self.embed.fields, field)
    end
    return self
end

function EmbedBuilder:setURL(url)
    self.embed.url = url
    return self
end

function EmbedBuilder:setImage(url, width, height, proxyURL)
    self.embed.image = { url = url, width = width, height = height, proxyURL = proxyURL }
    return self
end

function EmbedBuilder:setThumbnail(url, width, height, proxyURL)
    self.embed.thumbnail = { url = url, width = width, height = height, proxyURL = proxyURL }
    return self
end

---@param footer table Ex. { text = "...", iconURL = "...", proxyIconUrl = "..." } The 'iconURL' and the 'proxyIconURL' values can be omitted.
function EmbedBuilder:setFooter(footer)
    self.embed.footer = { text = footer.text, icon_url = footer.iconURL, proxy_icon_url = footer.proxyIconURL }
    return self
end

function EmbedBuilder:setTimestamp(timestamp)
    if timestamp == nil then
        timestamp = os.time()
    end
    self.embed.timestamp = timestamp
    return self
end

function EmbedBuilder:setVideo(url, width, height, proxyURL)
    self.embed.video = { url = url, width = width, height = height, proxyURL = proxyURL }
    return self
end

function EmbedBuilder:setProvider(name, url)
    self.embed.provider = { name = name, url = url }
    return self
end

function EmbedBuilder:toJSON()
    return json.stringify(self.embed)
end

return EmbedBuilder
