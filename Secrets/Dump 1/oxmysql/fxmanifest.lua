fx_version "bodacious"
game "gta5"
lua54 "yes"

version "2.9.1"

dependencies {
	"/server:5104"
}

server_script "server-side/server.js"

provide "mysql-async"