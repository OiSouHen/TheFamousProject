fx_version "bodacious"
game "gta5"

files {
	"data/**/*.meta",
	"audio/*",
	"audio/**/*",
}

data_file "HANDLING_FILE" "data/**/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/**/layouts/*.meta"
data_file "VEHICLE_METADATA_FILE" "data/**/vehicles.meta"
data_file "CARCOLS_FILE" "data/**/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/**/carvariations.meta"

data_file 'AUDIO_GAMEDATA' 'audio/nathanwh/nathanwh_game.dat'
data_file 'AUDIO_WAVEPACK' 'audio/nathanwh/dlc_nathanwh'
data_file 'AUDIO_SOUNDDATA' 'audio/nathanwh/nathanwh_sounds.dat'

data_file 'AUDIO_GAMEDATA' 'audio/nathanwhmike/nathanwhmike_game.dat'
data_file 'AUDIO_WAVEPACK' 'audio/nathanwhmike/dlc_nathanwhmike'
data_file 'AUDIO_SOUNDDATA' 'audio/nathanwhmike/nathanwhmike_sounds.dat'
dependency '/assetpacks'