local Snowflake = require("classes/Snowflake")
local DMChannel = require("classes/DMChannel")
local CDN = require("CDN")

local User = {
    id = nil,
    username = nil,
    discriminator = nil,
    tag = nil,
    avatar = nil,
    banner = nil,
    accentColor = nil,
    hexAccentColor = nil,
    createdAt = nil,
    createdTimestamp = nil,
    defaultAvatarURL = nil,
    bot = nil,
    flags = nil,
    system = nil,
    partial = nil,
    new =
        function (self, data)
            local function hexAccentColor()
                if not data.accent_color == nil then
                    return string.format("#%x", data.accent_color)
                end
                return nil
            end
            self.id = data.id
            self.username = data.username
            self.discriminator = data.discriminator
            self.tag = string.format("%s%s", self.username, self.discriminator)
            -- User avatar's hash
            self.avatar = data.avatar
            -- User banner's hash
            self.banner = data.banner
            self.accentColor = data.accent_color
            self.hexAccentColor = hexAccentColor()
            self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake.convertToTimestamp(self.id))
            self.createdTimestamp = Snowflake.convertToTimestamp(self.id)
            self.defaultAvatarURL = CDN.defaultAvatar(self.discriminator)
            self.bot = (data.bot == true and true or false)
            self.flags = data.public_flags
            self.system = (data.system == true and true or false)
            self.partial = not type(self.username) == "string"
            return self
        end
}

function User:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake.convertToTimestamp(self.id))
end

function User:avatarURL(options)
    return CDN.avatar(self.id, self.avatar, options)
end

function User:bannerURL(options)
    return CDN.banner(self.id, self.banner, options)
end

function User:displayAvatarURL(options)
    return self:avatarURL(options) or self.defaultAvatarURL
end

function User:equals(user)
    return (
        self.id == user.id and
        self.username == user.username and
        self.discriminator == user.discriminator and
        self.avatar == user.avatar and
        self.flags == user.flags and
        self.banner == user.banner and
        self.accentColor == user.accentColor
    )
end

function User.send(id, content)
    return DMChannel.send(id, content)
end

function User:toString()
    return string.format("<@%s>", self.id)
end

return User