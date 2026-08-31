class_name Lives
extends Node2D

@onready var life_1: Sprite2D = $Life1
@onready var life_2: Sprite2D = $Life2

func _ready() -> void:
	RemainingLives = 3

var RemainingLives: int:
	get: return RemainingLives
	set(value): RemainingLives = value
	
func UpdateLives() -> void:
	RemainingLives -= 1
	if RemainingLives == 2: life_1.hide()
	if RemainingLives == 1: life_2.hide()
