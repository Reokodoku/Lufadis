local lufadis = require("lufadis")
local API = lufadis.API.new()

local f = string.format

local token = "Bot <your-bot-token>" -- Token of Discord Bot
API:authenticate(token)

local user2 = lufadis.User.new(API:getUser("<user id>"))
local user = lufadis.User.new(API:getUser("<user id>"))

print("-- Properties --")

print(f("ID: %s", user.id))
print(f("Username: %s", user.username))
print(f("Discriminator: %s", user.discriminator))
print(f("Tag: %s", user.tag))
print(f("Avatar hash: %s", user.avatar))
print(f("Banner hash: %s", user.banner))
print(f("Is bot: %s", user.bot))
print(f("Flags: %s", user.flags))
print(f("Accent color: %s", user.accentColor))
print(f("Hex accent color: %s", user.hexAccentColor))
print(f("Created at: %s", user.createdAt))
print(f("Created timestamp: %s", user.createdTimestamp))
print(f("Default avatar URL: %s", user.defaultAvatarURL))
print(f("Is system: %s", user.system))
print(f("Is partial: %s", user.partial))

print("-- Methods --")

print(f("Created at custom: %s", user:createdAtCustom("/")))
print(f("Avatar URL: %s", user:avatarURL()))
print(f("Banner URL: %s", user:bannerURL()))
print(f("Display avatar URL: %s", user:displayAvatarURL()))
print(f("User 1 equals to user 2? %s", user:equals(user2)))
print(f("To string: %s", user:toString()))

user.send(API, user.id, "A DM Message!")
