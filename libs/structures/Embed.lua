local json = require('json')

local Embed = {
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
    new =
        function (self)
            return self
        end
}

function Embed:toJSON()
    return json.stringify({
        title = self.title,
        type = self.type,
        description = self.description,
        url = self.url,
        timestamp = self.timestamp,
        color = self.color,
        hexColor = self.color,
        footer = self.footer,
        image = self.image,
        thumbnail = self.thumbnail,
        video = self.video,
        provider = self.provider,
        author = self.author,
        fields = self.fields,
    })
end

function Embed:equals(other)
    return {
        title = self.title,
        type = self.type,
        description = self.description,
        url = self.url,
        timestamp = self.timestamp,
        color = self.color,
        hexColor = self.color,
        footer = self.footer,
        image = self.image,
        thumbnail = self.thumbnail,
        video = self.video,
        provider = self.provider,
        author = self.author,
        fields = self.fields,
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

return Embed
