#From https://youtu.be/gpvLqLggJuk
extends Camera2D
const SCR_NAME: String = "Camera.gd"

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
				# Logger.output(SCR_NAME, "Camera zoom:" + str(_zoom), 0)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out()
				# Logger.output(SCR_NAME, "Camera zoom:" + str(_zoom), 0)

func _physics_process(delta) -> void:
	zoom = lerp(zoom, _zoom * Vector2.ONE, zoom_speed * delta)
	# set_physics_process(not is_equal_approx(zoom.x, _zoom))

func zoom_in() -> void:
	_zoom = min(_zoom + zoom_value, zoom_max)
	# set_physics_process(true)

func zoom_out() -> void:
	_zoom = max(_zoom - zoom_value, zoom_min)
	# set_physics_process(true)

func camera_init() -> void:
	position = Vector2.ZERO
	_zoom = 1.2
	$Timer.start(0.05)
	# set_physics_process(true)

func _on_timer_timeout():
	self.zoom_out()
