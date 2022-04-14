local Snowflake = require("classes/Snowflake")
local DMChannel = require("classes/DMChannel")
local getURLs = require("utils/getURLs")

local f = string.format

local User = {}
User.__index = User

function User.new(data)
	local self = setmetatable({}, User)
    self._data = data or {}

    local function hexAccentColor()
        if self._data.accent_color == nil then
            return nil
        else
            return f("#%x", self._data.accent_color)
        end
    end

    self.id = self._data.id
    self.username = self._data.username
    self.discriminator = self._data.discriminator
    self.tag = f("%s%s", self.username, self.discriminator)
    -- User avatar's hash
    self.avatar = self._data.avatar
    -- User banner's hash
    self.banner = self._data.banner
    self.accentColor = self._data.accent_color
    self.hexAccentColor = hexAccentColor()
    self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake:convertToTimestamp(self.id))
    self.createdTimestamp = Snowflake:convertToTimestamp(self.id)
    self.defaultAvatarURL = getURLs.defaultAvatar(self.discriminator)
    self.bot = (self._data.bot == true and true or false)
    self.flags = self._data.public_flags
    self.system = (self._data.system == true and true or false)
    self.partial = not type(self.username) == "string"

    return self
end

function User:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake:convertToTimestamp(self.id))
end

function User:avatarURL(options)
    return getURLs.avatar(self.id, self.avatar, options)
end

function User:bannerURL(options)
    return getURLs.banner(self.id, self.banner, options)
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

function User.send(api, id, content)
    return DMChannel.send(api, id, content)
end

function User:toString()
    return f("<@%s>", self.id)
end

return User