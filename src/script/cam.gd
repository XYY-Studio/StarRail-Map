extends Camera2D
const SRC_NAME = "cam.gd"

func _ready():
	zoom = Vector2(scaleNum, scaleNum)
	Logger.output(SRC_NAME, "cam readt", 0)

# var mousePos
var startPos = Vector2.ZERO
var startCamPos = Vector2.ZERO
var dragging = false

# var MapZoom
@onready var camZoom = Vector2(scaleNum, scaleNum)
var scaleNum = 1
var zoomNum = 0.2
var minZoom = 0.8
var maxZoom = 3

func _process(delta):
	zoom = lerp(zoom, Vector2(scaleNum, scaleNum), delta * 10)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == false:
		dragging = false

		if self.position.x > self.limit_right:
			self.position.x = self.limit_right
			pass


func _input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			startPos = event.position
			startCamPos = self.position
			dragging = true
		else:
			startPos = Vector2.ZERO
			dragging = false
	
	if event is InputEventMouseButton:
		if event.button_index == 4:
			print(scaleNum)
			startPos = Vector2.ZERO
			if scaleNum <= maxZoom:
				scaleNum += zoomNum
			
		elif event.button_index == 5:
			print(scaleNum)
			startPos = Vector2.ZERO
			if scaleNum >= minZoom:
				scaleNum -= zoomNum
			
	
	if dragging:
		if startPos != Vector2.ZERO:
			var offsetPos = startPos - event.position
			self.position = startCamPos + offsetPos / scaleNum
		if self.position.x > self.limit_right:
			self.position.x = self.limit_right
