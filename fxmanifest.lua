fx_version 'cerulean'
game 'gta5'

author 'maco_05'
description 'Simple to use addon to manage temporary permissions for fiveguard'
version '2.1.5'

shared_script 'config.lua'

client_scripts {
    'client/client.lua',
    'client/addon/*.lua'
}

server_scripts {
    'server/server.lua',
    'server/addon/*.lua'
}
