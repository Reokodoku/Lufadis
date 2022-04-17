local lufadis = require("lufadis")

local f = string.format

local webhook = lufadis.Webhook.new("<your-webhook-url>")

print("-- Properties --")

print(f("Type: %s", webhook.type))
print(f("Token: %s", webhook.token))
print(f("ID: %s", webhook.id))
print(f("Name: %s", webhook.name))
print(f("Avatar hash: %s", webhook.avatar))
print(f("Channel ID: %s", webhook.channelId))
print(f("Guild ID: %s", webhook.guildId))
print(f("Created at: %s", webhook.createdAt))
print(f("Created timestamp: %s", webhook.createdTimestamp))
print(f("Webhook's owner: %s", webhook.owner))
print(f("Source channel: %s", webhook.sourceChannel))
print(f("Source guild: %s", webhook.sourceGuild))
print(f("Webhook's URL: %s", webhook.url))

print("-- Methods --")

print(f("Created at custom: %s", webhook:createdAtCustom("/")))
print(f("Avatar URL: %s", webhook:avatarURL()))

webhook:send({ content = "It works!" });
