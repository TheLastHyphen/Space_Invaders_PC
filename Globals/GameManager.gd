extends Node

const MAIN = preload("uid://rd3t63ncguuq")
const GAME = preload("uid://dqn8mv6t6evrv")

func LoadGame() -> void:
	get_tree().change_scene_to_packed(GAME)
	
func LoadMain() -> void:
	get_tree().change_scene_to_packed(MAIN)
