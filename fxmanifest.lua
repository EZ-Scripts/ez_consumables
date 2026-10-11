fx_version 'cerulean'
games {'rdr3'}
lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name 'ez_consumables'
author 'Rayaan Uddin'
version '2.0.0'
description 'Food, drink, medicine and packs kept in the database and managed in game with /manageconsumables'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/assets/**/*',
}

shared_scripts {
    'shared/config.lua',
    'shared/screeneffects.lua',
    'shared/lang.lua',
    'shared/functions.lua',
}

client_scripts {
    'client/functions.lua',
    'client/smoking.lua',
    'client/animations.lua',
    'client/effects.lua',
    'client/main.lua',
    'client/nui.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/config.lua',
    'server/framework.lua',
    'server/database.lua',
    'server/main.lua',
    'server/admin.lua',
    'server/migrate.lua',
}

dependencies {
    'vorp_core',
    'vorp_inventory',
    'oxmysql',
}
