local Snowflake = require("classes/Snowflake")
local getURLs = require("utils/getURLs")
local otherUtil = require("utils/other")

local Guild = {
    id = nil,
    name = nil,
    description = nil,
    icon = nil,
    banner = nil,
    splash = nil,
    discoverySplash = nil,
    createdAt = nil,
    createdTimestamp = nil,
    ownerId = nil,
    preferredLocale = nil,
    features = nil,
    roles = nil,
    verified = nil,
    partnered = nil,
    afkChannelId = nil,
    afkTimeout = nil,
    mfaLevel = nil,
    nsfwLevel = nil,
    new =
        function (self, data)
            self.id = data.id
            self.name = data.name
            self.description = data.description
            -- Guild icon's hash
            self.icon = data.icon
            -- Guild banner's hash
            self.banner = data.banner
            -- Splash guild invite image hash
            self.splash = data.splash
            -- Discovery splash image hash
            self.discoverySplash = data.discovery_splash
            self.createdAt = os.date('%Y-%m-%d %H:%M:%S', Snowflake.convertToTimestamp(self.id))
            self.createdTimestamp = Snowflake.convertToTimestamp(self.id)
            self.ownerId = data.owner_id
            self.preferredLocale = data.preferred_locale
            self.features = data.features
            self.roles = data.roles
            self.verified = otherUtil.isInArrayJSON(self.features["VERIFIED"])
            self.partnered = otherUtil.isInArrayJSON(self.features["PARTNERED"])
            self.afkChannelId = data.afk_channel_id
            self.afkTimeout = data.afk_timeout
            self.mfaLevel = data.mfa_level
            self.nsfwLevel = data.nsfw_level
            return self
        end
}

function Guild:createdAtCustom(separator, centralSeparator)
    separator = separator or "-"
    centralSeparator = centralSeparator or ""
    return os.date('%Y' .. separator .. '%m' .. separator .. '%d ' .. centralSeparator .. '%H:%M:%S', Snowflake.convertToTimestamp(self.id))
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
