fx_version 'cerulean'
game 'gta5'

author 'maco_05'
description 'Simple to use addon to manage temporary permissions for fiveguard'
version '2.2.0'

shared_script 'config.lua'

client_scripts {
    'client/cl_main.lua',
    'client/addon/*.lua'
}

server_scripts {
    'server/sv_main.lua',
    'server/addon/*.lua'
}
