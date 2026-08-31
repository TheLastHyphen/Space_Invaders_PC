extends Control

@onready var score_label: Label = $HBoxContainer/VBoxContainer/Score
@onready var hi_score_label: Label = $HBoxContainer/VBoxContainer2/Hi_Score

func _ready() -> void:
	hi_score_label.text = "%04d" % HighScore.HighScore
	var n: StringName = get_tree().get_current_scene().name
	if n != "Main":
		FlashScore()

func ClearScore() -> void:
	score_label.text = "%04d" % 0
	hi_score_label.text = "%04d" % 0

func UpdateScores(score: int) -> void:
	score_label.text = "%04d" % score
	if score > HighScore.HighScore:
		UpdateHighScore(score)

func UpdateHighScore(score: int) -> void:
	HighScore.HighScore = score
	hi_score_label.text = "%04d" % HighScore.HighScore

func SetInitialHighScore() -> void:
	UpdateHighScore(HighScore.HighScore)

func FlashScore() -> void:
	for i in range(44):
		score_label.visible = !score_label.visible
		await  get_tree().create_timer(0.04).timeout
