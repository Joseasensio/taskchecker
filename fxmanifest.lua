fx_version 'cerulean'
game 'gta5'

author 'Asensur/DynamiteHeaddy'
description 'Checks armour and applies correct task'
version '1.0.0'

lua54 "yes"

dependencies {
    '/server:7290',
    '/onesync',
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client/main.lua'
}

files {
    'client/data/tasklist.lua',
    'client/data/exceptionlist.lua'
}
