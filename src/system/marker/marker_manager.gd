extends Node

var marker_sce :PackedScene

func _ready() -> void:
	marker_sce = preload("res://src/system/marker/scenes/item.tscn")
	
	#test()

func add_marker(position:Vector2, type:String, category:String, icon:Texture = null, text:String = "", texture:Texture = null):
	var marker = marker_sce.instantiate()
	
	marker.position = position
	marker.set_type_text(type)
	marker.set_category_text(category)
	marker.set_icon(icon)
	marker.set_text(text)
	marker.set_texture(texture)
	
	add_child(marker)

func test() -> void:
	add_marker(Vector2(23,45), "test", "test", null, "233")
