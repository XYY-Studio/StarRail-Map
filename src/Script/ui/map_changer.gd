extends CanvasLayer
const SCR_NAME = "map_changer.gd"
#TODO…

func change_map_begin() -> void:
	self.show()
	$AnimationPlayer.play("changer_light")
	print("Change Map")

func chang_map_end() -> void:
	self.hide()
	$AnimationPlayer.play_backwards("changer_light")
