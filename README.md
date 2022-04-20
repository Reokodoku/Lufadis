<div align="center">
  <br />
  <p>
    <a href="https://github.com/Reokodoku/Lufadis"><img src="https://github.com/Reokodoku/Lufadis/blob/main/images/LufadisImage.png" width="600" alt="Lufadis" /></a>
  </p>
  <br />
  <p>
    <a href="https://github.com/Reokodoku/Lufadis/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License" /></a>
  </p>
</div>

**A [Discord](https://discord.com) API Wrapper written in Lua for [Luvit](https://luvit.io)!**

# Notice
This library has not yet been completed. There will be updates, frequently or not.

# Installation

- Install Luvit (visit https://luvit.io and follow the instructions to install it);
- Install Lufadis via the lit package manager (`lit install Reokodoku/lufadis`);
- For run your bot, run the `luvit` command (for example: `luvit exampleFile.lua`).

# Example usage

To get started import Lufadis, create a new class API and authenticate:

```lua
local lufadis = require("lufadis")
local API = lufadis.API.new()

API.authenticate("<your-token>")
```

Now you can call the User class, Message class, Guild class, etc...
```lua

-- Guild class
local guild = lufadis.Guild.new(API:getGuild("<guild-id>"))
print(string.format("Guild's ID: %s", guild.id))
print(string.format("Guild's name: %s", guild.name))
print(string.format("Guild's description: %s", guild.description))

-- User class
local user = lufadis.User.new(API:getUser("<user-id>"))
print(string.format("User's ID: %s", user.id))
print(string.format("User's username: %s", user.username))
print(string.format("User's discriminator: %s", user.discriminator))
```

There are other examples in the `examples` folder
