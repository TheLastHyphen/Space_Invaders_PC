extends Node

const SAVE_PATH: String = "user://space_invaders_high_score.dat"

var HighScore: int:
	get: return HighScore
	set(value): HighScore = value

func SaveHighScore() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if !file:
		push_error("save_to_file no file found!")
		return
	file.store_32(HighScore)

func LoadHiScore() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if !file:
		push_error("load_from_file no file found!")
		return
	HighScore = file.get_32()
