local constants = require("constants")

local CDN = {}
CDN.__index = CDN

function CDN.avatar(id, avatarHash, options)
    if avatarHash == nil then
        return nil
    else
        options = options or { forceStatic = false, extension = "png" }
        local url = constants.CDN .. "/avatars/" .. id .. "/" .. avatarHash
        if options.forceStatic == false and string.sub(avatarHash, 1, string.len("_a")) == "_a" then
            options = { extension = 'gif' }
        end
        return url .. "." .. options.extension
    end
end

function CDN.defaultAvatar(discriminator)
	return constants.CDN .. "/embed/avatars/" .. discriminator % 5 .. ".png"
end

function CDN.banner(id, bannerHash, options)
    if bannerHash == nil then
        return nil
    else
        options = options or { forceStatic = false, extension = "png" }
        local url = constants.CDN .. "/banners/" .. id .. "/" .. bannerHash
        if options.forceStatic == false and string.sub(bannerHash, 1, string.len("_a")) == "_a" then
            options = { extension = 'gif' }
        end
        return url .. "." .. options.extension
    end
end


return CDN