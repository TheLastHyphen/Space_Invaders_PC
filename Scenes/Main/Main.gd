extends Control

@onready var score_advance_table: ScoreTable = $ScoreAdvanceTable
@onready var play_label: Label = $Control/HBoxContainer/Play
@onready var space_label: Label = $Control/HBoxContainer3/SpaceText
@onready var invader_label: Label = $Control/HBoxContainer3/InvaderText
@onready var start_game_label: Label = $HBoxContainer/StartGameLabel

const SCORE_ADVANCE_TABLE = preload("uid://dn4aehjlpr3n4")

var charDelay: float = 0.06
var startGameCharDelay = 0.13
var playText: String = "PLAY"
var spaceText = "SPACE"
var invaderText = "INVADERS"
var startGameText = "PRESS 1 TO START THE GAME"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("StartGame"):
		score_advance_table.queue_free()
		GameManager.LoadGame()

func _ready() -> void:
	ScoreDisplay.ClearScore()
	get_tree().paused = false
	play_label.text = ""
	space_label.text = ""
	invader_label.text = ""
	start_game_label.text = ""
	await DrawText(playText, play_label, charDelay)
	await DrawText(spaceText, space_label, charDelay)
	await DrawText(invaderText, invader_label, charDelay)
	await get_tree().create_timer(1.5).timeout
	score_advance_table = SCORE_ADVANCE_TABLE.instantiate()
	score_advance_table.position = Vector2(0, 45.0)
	get_tree().get_root().add_child(score_advance_table)
	start_game_label.show()
	DrawText(startGameText, start_game_label, startGameCharDelay)

func DrawText(text: String, label: Label, delay: float) -> void:
	for s in text:
		label.text += s
		await WaitDrawChar(delay)

func WaitDrawChar(delay: float) -> void:
	await get_tree().create_timer(delay).timeout
