extends Control

@onready var game_label: Label = $HBoxContainer/GameLabel
@onready var over_label: Label = $HBoxContainer/OverLabel

var charDelay: float = 0.25
var gameText = "GAME"
var overText = "OVER"

func _ready() -> void:
	game_label.text = ""
	over_label.text = ""
	await DrawText(gameText, game_label)
	await DrawText(overText, over_label)

func DrawText(text: String, label: Label) -> void:
	for s in text:
		label.text += s
		await WaitDrawChar()

func WaitDrawChar() -> void:
	await get_tree().create_timer(charDelay).timeout
