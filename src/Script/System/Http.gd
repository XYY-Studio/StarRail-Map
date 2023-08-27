extends HTTPRequest
const SCR_NAME = "Http.gd"

func _ready():
	set_http_proxy("127.0.0.1", 7890)
	set_https_proxy("127.0.0.1", 7890)
	
	# request("https://raw.githubusercontent.com/Xyyaua/Map-data-sr/main/version.json")

func _on_request_completed(result, response_code, headers, body):
	# var rsu = Util.get_json_data(body.get_string_from_utf8())
	Logger.output(SCR_NAME, "Get result: " + str(result), 1)
	Logger.output(SCR_NAME, "Get code: " + str(response_code), 1)
	Logger.output(SCR_NAME, "Get head: " + str(headers), 1)
	Logger.output(SCR_NAME, "Get body: " + str(body.get_string_from_utf8()), 1)
