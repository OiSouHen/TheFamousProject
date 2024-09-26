fx_version "bodacious"
game "gta5"

files {
	"data/**/*.meta",
	"audio/*",
	"audio/**/*"
}

data_file "HANDLING_FILE" "data/**/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/**/layouts/*.meta"
data_file "VEHICLE_METADATA_FILE" "data/**/vehicles.meta"
data_file "CARCOLS_FILE" "data/**/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/**/carvariations.meta"
dependency '/assetpacks'