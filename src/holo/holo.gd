extends Control

@onready var holo_ui := $HoloUi

func show_holo(value: bool) -> void:
	set_visible(value)
	holo_ui.set_visible(value)

func add_world_option(value: int) -> void:
	holo_ui.add_world_option(value)
