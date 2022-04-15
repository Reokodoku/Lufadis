local lufadis = require("lufadis")
local API = lufadis.API.new()

local f = string.format

local token = "Bot <your-bot-token>" -- Token of Discord Bot
API:authenticate(token)

local guild = lufadis.Guild.new(API:getGuild("929817423165677568"))

print("-- Properties --")

print(f("ID: %s", guild.id))
print(f("Name: %s", guild.name))
print(f("Description: %s", guild.description))
print(f("Icon hash: %s", guild.icon))
print(f("Banner hash: %s", guild.banner))
print(f("Splash hash: %s", guild.splash))
print(f("Discovery splash hash: %s", guild.discoverySplash))
print(f("Created at: %s", guild.createdAt))
print(f("Created timestamp: %s", guild.createdTimestamp))
print(f("Owner ID: %s", guild.ownerId))
print(f("Preferred locale: %s", guild.preferredLocale))
print(f("Features: %s", guild.features))
print(f("Roles: %s", guild.roles))
print(f("Is verified: %s", guild.verified))
print(f("Is partnered: %s", guild.partnered))
print(f("MFA level: %s", guild.mfaLevel))
print(f("NSFW Level: %s", guild.nsfwLevel))
print(f("AFK channel id: %s", guild.afkChannelId))
print(f("AFK timeout: %s", guild.afkTimeout))

print("-- Methods --")

print(f("Created at custom: %s", guild:createdAtCustom("/")))
print(f("Icon URL: %s", guild:iconURL()))
print(f("Banner URL: %s", guild:bannerURL()))
print(f("Splash URL: %s", guild:splashURL()))
print(f("Discovery splash URL: %s", guild:discoverySplashURL()))
print(f("To string: %s", guild:toString()))

--guild:delete(API)