local Snowflake = require("classes/Snowflake")
local getURLs = require("utils/getURLs")
local otherUtil = require("utils/other")

local f = string.format

local Guild = {}
Guild.__index = Guild

function Guild.new(data)
	local self = setmetatable({}, Guild)
    self._data = data or {}

    --print(self._data.message)

    self.id = self._data.id
    self.name = self._data.name
    self.description = self._data.description
    -- Guild icon's hash
    self.icon = self._data.icon
    -- Guild banner's hash
    self.banner = self._data.banner
    -- Splash guild invite image hash
    self.splash = self._data.splash
    -- Discovery splash image hash
    self.discoverySplash = self._data.discovery_splash
    self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake:convertToTimestamp(self.id))
    self.createdTimestamp = Snowflake:convertToTimestamp(self.id)
    self.ownerId = self._data.owner_id
    self.preferredLocale = self._data.preferred_locale
    self.features = self._data.features
    self.roles = self._data.roles
    self.verified = otherUtil:isInArrayJSON(self.features["VERIFIED"])
    self.partnered = otherUtil:isInArrayJSON(self.features["PARTNERED"])
    self.afkChannelId = self._data.afk_channel_id
    self.afkTimeout = self._data.afk_timeout
    self.mfaLevel = self._data.mfa_level
    self.nsfwLevel = self._data.nsfw_level

    return self
end

function Guild:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake:convertToTimestamp(self.id))
end

function Guild:iconURL(options)
    return getURLs.icon(self.id, self.icon, options)
end

function Guild:bannerURL(options)
    return getURLs.banner(self.id, self.banner, options)
end

function Guild:splashURL()
    return getURLs.splash(self.id, self.splash)
end

function Guild:discoverySplashURL()
    return getURLs.splash(self.id, self.splash)
end

function Guild:delete(api)
    return api:deleteGuild(self.id)
end

function Guild:toString()
    return self.name
end

return Guild