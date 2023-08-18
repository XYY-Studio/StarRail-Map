extends Node
const SCR_NAME: String = "Util.gd"

var json = JSON.new()

func get_json_data(file):
	var json_string = JSON.stringify(file.get_as_text())
	var err = json.parse(file.get_as_text())
	
	if err == OK:
		var json_data = json.data
		if typeof(json_data) == TYPE_DICTIONARY:
			return json_data
		
		else:
			Logger.output(SCR_NAME, "Data type is not Dictionary: " + json_data, 2)
	else:
		var json_err = "JSON Parse Error: " + json.get_error_message() + " in " + json_string + " at line " + json.get_error_line()
		Logger.output(SCR_NAME, json_err, 3)
