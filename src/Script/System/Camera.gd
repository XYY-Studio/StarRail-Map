#From https://youtu.be/gpvLqLggJuk
extends Camera2D

var _zoom: float = 1.0
var zoom_value: float = 0.2
var zoom_max: float = 2.2
var zoom_min: float = 0.6
var zoom_speed: float = 8.0

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative / zoom
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_in()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out()

func _physics_process(delta) -> void:
	zoom = lerp(zoom, _zoom * Vector2.ONE, zoom_speed * delta)

func zoom_in() -> void:
	_zoom = min(_zoom + zoom_value, zoom_max)

func zoom_out() -> void:
	_zoom = max(_zoom - zoom_value, zoom_min)

func set_camera_zoom(value: float) -> void:
	if value >= zoom_min && value <= zoom_max:
		_zoom = value
	elif value < zoom_min:
		_zoom = zoom_min
	elif value > zoom_max:
		_zoom = zoom_max

func camera_init() -> void:
	position = Vector2.ZERO
	_zoom = 1.0

func set_camera_limit():
	#TODO…
	#Left: -2048
	#Top: -1024
	#Right: 2048
	#Bottom: 1024
	pass
