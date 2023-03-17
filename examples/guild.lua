local lufadis = require("lufadis")
local API = lufadis.API:new()

local token = "Bot <your-bot-token>" -- Token of Discord Bot
API:authenticate(token)

local guild = lufadis.Guild:new(API:getGuild("<your-guild-id>"))

print("-- Properties --")

print(string.format("ID: %s", guild.id))
print(string.format("Name: %s", guild.name))
print(string.format("Description: %s", guild.description))
print(string.format("Icon hash: %s", guild.icon))
print(string.format("Banner hash: %s", guild.banner))
print(string.format("Splash hash: %s", guild.splash))
print(string.format("Discovery splash hash: %s", guild.discoverySplash))
print(string.format("Created at: %s", guild.createdAt))
print(string.format("Created timestamp: %s", guild.createdTimestamp))
print(string.format("Owner ID: %s", guild.ownerId))
print(string.format("Preferred locale: %s", guild.preferredLocale))
print(string.format("Features: %s", guild.features))
print(string.format("Roles: %s", guild.roles))
print(string.format("Is verified: %s", guild.verified))
print(string.format("Is partnered: %s", guild.partnered))
print(string.format("MFA level: %s", guild.mfaLevel))
print(string.format("NSFW Level: %s", guild.nsfwLevel))
print(string.format("AFK channel id: %s", guild.afkChannelId))
print(string.format("AFK timeout: %s", guild.afkTimeout))

print("-- Methods --")

print(string.format("Created at custom: %s", guild:createdAtCustom("/")))
print(string.format("Icon URL: %s", guild:iconURL()))
print(string.format("Banner URL: %s", guild:bannerURL()))
print(string.format("Splash URL: %s", guild:splashURL()))
print(string.format("Discovery splash URL: %s", guild:discoverySplashURL()))
print(string.format("To string: %s", guild:toString()))

--guild:delete(API)