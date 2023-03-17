local constants = require("constants")

local CDN = {}

function CDN.avatar(id, avatarHash, options)
    if not avatarHash == nil then
        options = options or { forceStatic = false, extension = "png" }
        local url = constants.CDN .. "/avatars/" .. id .. "/" .. avatarHash
        if options.forceStatic == false and string.sub(avatarHash, 1, string.len("_a")) == "_a" then
            options = { extension = 'gif' }
        end
        return url .. "." .. options.extension
    end
    return nil
end

function CDN.defaultAvatar(discriminator)
	return constants.CDN .. "/embed/avatars/" .. discriminator % 5 .. ".png"
end

function CDN.banner(id, bannerHash, options)
    if not bannerHash == nil then
        options = options or { forceStatic = false, extension = "png" }
        local url = constants.CDN .. "/banners/" .. id .. "/" .. bannerHash
        if options.forceStatic == false and string.sub(bannerHash, 1, string.len("_a")) == "_a" then
            options = { extension = 'gif' }
        end
        return url .. "." .. options.extension
    end
    return nil
end

function CDN.splash(id, splashHash)
    if not splashHash == nil then
        local url = constants.CDN .. "/splashes/" .. id .. "/" .. splashHash
        return url .. "." .. ".png"
    end
    return nil
end

function CDN.discoverySplash(id, discoverySplashHash)
    if not discoverySplashHash == nil then
        local url = constants.CDN .. "/discovery-splashes/" .. id .. "/" .. discoverySplashHash
        return url .. "." .. ".png"
    end
    return nil
end

function CDN.icon(id, iconHash, options)
    if not iconHash == nil then
        options = options or { forceStatic = false, extension = "png" }
        local url = constants.CDN .. "/icons/" .. id .. "/" .. iconHash
        if options.forceStatic == false and string.sub(iconHash, 1, string.len("_a")) == "_a" then
            options = { extension = 'gif' }
        end
        return url .. "." .. options.extension
    end
    return nil
end

return CDN
