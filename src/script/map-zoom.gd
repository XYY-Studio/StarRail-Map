# This script is deprecated. Do not change it
# 这个脚本已弃用.不要更改它
extends Node

@onready var SLIDER = $"zoom-slider"
var zoom = 1

func _on_zoomout_pressed():
	SLIDER.value -= zoom

func _on_zoomin_pressed():
	SLIDER.value += zoom

func _on_zoomslider_value_changed(value):
	var v = str(value)
	print("Slider: " + v)
