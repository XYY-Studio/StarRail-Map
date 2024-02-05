extends Node
const SRC_NAME = "Util.gd"

var get_map = {}
var mapJson = "res://resource/data/map.json"

func _ready():
	getMapJson()
	
	var time = Time.get_time_string_from_system(false)
	print(time)
	
	if get_map != {}:
		print(get_map)
	else :
		Logger.output(SRC_NAME, "Can't print map!", 3)

func getMapJson():
	get_map = map(mapJson)
	pass


func map(mapFile: String):
	if FileAccess.file_exists(mapFile):
		var openMapJson = FileAccess.open(mapFile, FileAccess.READ)
		var json = JSON.parse_string(openMapJson.get_as_text())
		if json is Dictionary:
			return json
		else:
			var logText = "Error to reading " + mapFile + " !"
			Logger.output(SRC_NAME, logText, 3)
			# print("Error to reading " + mapFile + " !")
	else:
		Logger.output(SRC_NAME, "File doesn't exist!", 3)
		# print("File doesn't exist!")
