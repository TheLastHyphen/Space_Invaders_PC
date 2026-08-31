class_name BunkerBlock
extends Area2D

@onready var frame_0: Sprite2D = $Frame0
@onready var frame_1: Sprite2D = $Frame1
@onready var frame_2: Sprite2D = $Frame2
@onready var frame_3: Sprite2D = $Frame3

var frame: int = 0
var missingPixels: Array

func _on_area_entered(area: Area2D) -> void:
	if area.collision_mask == 259:
		queue_free()
		return
	frame += 1
	if frame == 4:
		queue_free()
	if frame == 1:
		frame_0.hide()
		frame_1.show()
		frame_2.hide()
		frame_3.hide()
	if frame == 2:
		frame_0.hide()
		frame_1.hide()
		frame_2.show()
		frame_3.hide()
	if frame == 3:
		frame_0.hide()
		frame_1.hide()
		frame_2.hide()
		frame_3.show()
