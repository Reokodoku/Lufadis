--[=[
    Variables that determine the endpoint from which to take the information.
    Example:
        http.request("GET", "https://discord.com/api/v10/" + string.format(USER, "_userId_", headers)
]=]
return {
	CHANNEL             	= "/channels/%s",
	CHANNEL_MESSAGE     	= "/channels/%s/messages/%s",
	CHANNEL_MESSAGES    	= "/channels/%s/messages",
	GUILD          			= "/guilds/%s",
	GUILDS         			= "/guilds",
	GUILD_CHANNELS      	= "/guilds/%s/channels",
	GUILD_WEBHOOKS			= "/guilds/%s/webhooks",
	USER           			= "/users/%s",
	ME             			= "/users/@me",
	ME_CHANNELS    			= "/users/@me/channels",
	ME_GUILD       			= "/users/@me/guilds/%s",
	ME_GUILDS      			= "/users/@me/guilds",
	WEBHOOK					= "/webhooks/%s",
	WEBHOOK_TOKEN			= "/webhooks/%s/%s",
	WEBHOOK_TOKEN_MESSAGE	= "/webhooks/%s/%s/messages/%s"
}
