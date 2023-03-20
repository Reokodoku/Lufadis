local lufadis = require("lufadis")

local webhook = lufadis.Webhook.new("<your-webhook-url>")

print("-- Properties --")

print(string.format("Type: %s", webhook.type))
print(string.format("Token: %s", webhook.token))
print(string.format("ID: %s", webhook.id))
print(string.format("Name: %s", webhook.name))
print(string.format("Avatar hash: %s", webhook.avatar))
print(string.format("Channel ID: %s", webhook.channelId))
print(string.format("Guild ID: %s", webhook.guildId))
print(string.format("Created at: %s", webhook.createdAt))
print(string.format("Created timestamp: %s", webhook.createdTimestamp))
print(string.format("Webhook's owner: %s", webhook.owner))
print(string.format("Source channel: %s", webhook.sourceChannel))
print(string.format("Source guild: %s", webhook.sourceGuild))
print(string.format("Webhook's URL: %s", webhook.url))

print("-- Methods --")

print(string.format("Created at custom: %s", webhook:createdAtCustom("/")))
print(string.format("Avatar URL: %s", webhook:avatarURL()))

webhook:send({ content = "It works!" })
webhook:send("It works with a normal string!")
print(webhook:fetchMessage("<message-id>").createdAt)
