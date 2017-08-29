resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
description "Menu Perso No Brain"

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- nb_menuperso
---------------------------------------------------------------------------------------------------------------------------------------------------------
client_script 'client.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server.lua'
}