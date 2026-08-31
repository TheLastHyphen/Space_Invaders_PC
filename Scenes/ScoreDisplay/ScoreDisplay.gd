extends Control

@onready var score_label: Label = $HBoxContainer/VBoxContainer/Score
@onready var hi_score_label: Label = $HBoxContainer/VBoxContainer2/Hi_Score

func _ready() -> void:
	hi_score_label.text = "%04d" % HighScore.HighScore

func ClearScore() -> void:
	score_label.text = "%04d" % 0

func UpdateScores(score: int) -> void:
	score_label.text = "%04d" % score
	if score > HighScore.HighScore:
		UpdateHighScore(score)
		#HighScore.HighScore = highScore
	
func UpdateHighScore(score: int) -> void:
	HighScore.HighScore = score
	hi_score_label.text = "%04d" % HighScore.HighScore
