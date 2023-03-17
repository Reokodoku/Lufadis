local lufadis = require("lufadis")
local API = lufadis.API:new()

local token = "Bot <your-bot-token>" -- Token of Discord Bot
API:authenticate(token)

local user2 = lufadis.User:new(API:getUser("<user id>"))
local user = lufadis.User:new(API:getUser("<user id>"))

print("-- Properties --")

print(string.format("ID: %s", user.id))
print(string.format("Username: %s", user.username))
print(string.format("Discriminator: %s", user.discriminator))
print(string.format("Tag: %s", user.tag))
print(string.format("Avatar hash: %s", user.avatar))
print(string.format("Banner hash: %s", user.banner))
print(string.format("Is bot: %s", user.bot))
print(string.format("Flags: %s", user.flags))
print(string.format("Accent color: %s", user.accentColor))
print(string.format("Hex accent color: %s", user.hexAccentColor))
print(string.format("Created at: %s", user.createdAt))
print(string.format("Created timestamp: %s", user.createdTimestamp))
print(string.format("Default avatar URL: %s", user.defaultAvatarURL))
print(string.format("Is system: %s", user.system))
print(string.format("Is partial: %s", user.partial))

print("-- Methods --")

print(string.format("Created at custom: %s", user:createdAtCustom("/")))
print(string.format("Avatar URL: %s", user:avatarURL()))
print(string.format("Banner URL: %s", user:bannerURL()))
print(string.format("Display avatar URL: %s", user:displayAvatarURL()))
print(string.format("User 1 equals to user 2? %s", user:equals(user2)))
print(string.format("To string: %s", user:toString()))

user.send(user.id, "A DM Message!")
