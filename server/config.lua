-- Server only settings. Clients never download this file

-- Discord webhook for what admins change, set in server.cfg / webhooks.cfg:
--   set ez_consumables_webhook "https://discord.com/api/webhooks/..."
Config.Webhook = GetConvar("ez_consumables_webhook", "")

Config.LogColors = {
    admin = "#d9b45a",
    delete = "#c4151c",
}

-- The old config, read once by ez_consumables_migrate
Config.LegacyConfig = "_legacy/shared/config.lua"
Config.LegacyTobacco = "_legacy/tobacco/config.lua" -- ez_tobacco's config, read by ez_consumables_migrate tobacco
