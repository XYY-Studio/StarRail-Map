extends Control

@onready var info_panel = $Panel
@onready var info_box = $Panel/InfoBox
@onready var type_lbl = $Panel/InfoBox/Type/Type
@onready var category_lbl = $Panel/InfoBox/Category/Category
@onready var texture = $Panel/InfoBox/TextureRect
@onready var textbox = $Panel/InfoBox/Text
@onready var btn = $BtnItem

var info_panel_size = Vector2(400, 100)
var show_panel :bool
var base_zoom :float = 1.0
var is_ready :bool

signal readied

func _ready() -> void:
	set_panel_visible(false)
	#info_panel._set_size(info_panel_size)
	update_panel_size()
	
	is_ready = true
	emit_signal("readied")

func _process(delta: float) -> void:
	self.set_scale(Vector2(base_zoom / Camera.zoom.x, base_zoom / Camera.zoom.y))

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if not event.is_pressed():
			#set_panel_visible(false)

func set_panel_visible(value: bool) -> void:
	var tween :Tween = create_tween()
	show_panel = value
	
	if value:
		info_panel.set_visible(true)
		tween.tween_property(info_panel, "modulate:a", 1, 0.1)
	else:
		tween.tween_property(info_panel, "modulate:a", 0, 0.1)
		await tween.finished
		info_panel.set_visible(false)

func update_panel_size() -> void:
	var info_box_size = info_box.size
	info_panel.size = Vector2(info_box_size.x + 20,info_box_size.y + 20)

#------------------------

func set_pos(pos: Vector2) -> void:
	self.set_position(pos)

func set_icon(icon) -> void:
	if icon != null:
		btn.icon = icon

func set_type_text(_text: String) -> void:
	if not is_ready:
		await readied
	
	type_lbl.set_text(_text)

func set_category_text(text: String) -> void:
	if not is_ready:
		await readied
	
	category_lbl.text = text

func set_text(_text: String) -> void:
	if not is_ready:
		await readied
	
	textbox.text = _text

func set_texture(texture: Texture) -> void:
	if not is_ready:
		await readied
	
	if texture != null:
		texture.set_texture(texture)

#------------------------

func _on_info_box_resized() -> void:
	if not is_ready:
		await readied
	
	update_panel_size()


func _on_btn_item_pressed() -> void:
	set_panel_visible(true)

func _on_btn_close_info_pressed() -> void:
	set_panel_visible(false)
