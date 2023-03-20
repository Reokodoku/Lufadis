local lufadis = require("lufadis")
local Embed = lufadis.Embed

local webhook = lufadis.Webhook.new("<your-webhook-url>")

local embed1 =
        lufadis.EmbedBuilder.new()
            :setTitle("Embed title")
            :setColor(0xFF0000)
            :setDescription("Embed description")
            :setFields({
                { name = "First", value = "1", inline = true },
                { name = "Second", value = "2", inline = false },
                { name = "Third", value = "3" },
            })
            :setImage("https://github.com/Reokodoku/Lufadis/raw/main/images/LufadisImage.png")

local embed2 =
        lufadis.EmbedBuilder.new()
            :setTitle("Lufadis")
            :setColor(0x0000FF)
            :setURL("https://github.com/Reokodoku/Lufadis")
            :setThumbnail("https://github.com/Reokodoku/Lufadis/raw/main/images/LufadisImage.png")
            :setFields({
                { name = "It's an API Wrapper for for:", value = "Discord API"},
            })
            :addFields(
                { name = "It's only written in:", value = "Lua" },
                { name = "Lufadis uses:", value = "Luvit" }
            )

print("Embed 1 is validate: ".. tostring(Embed.fromTable(embed1.embed):validate()))

webhook:send({ embeds = {embed1.embed, embed2.embed} })
