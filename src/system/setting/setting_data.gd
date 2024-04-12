extends Resource
#TODO
#Save & Load Settings

var cfg := ConfigFile.new()

#------------------------
#	Data

var default := {}
var settings := {}

#------------------------
#	Func

##	Save&Load

func save_setting(key: String, value) -> void:
	settings[key] = value
	
	print("settings: ",settings)
	for i in settings:
		print(i)

func load_setting() -> void:
	pass
