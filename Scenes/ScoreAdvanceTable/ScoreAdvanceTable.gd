class_name ScoreTable
extends Control

@onready var mystery_text_label: Label = $HBoxContainer/VBoxContainer2/mysteryTextLabel
@onready var squid_text_label: Label = $HBoxContainer/VBoxContainer2/squidTextLabel
@onready var crab_text_label: Label = $HBoxContainer/VBoxContainer2/crabTextLabel
@onready var octopus_text_label: Label = $HBoxContainer/VBoxContainer2/octopusTextLabel

var charDelay: float = 0.06
var mysteryPointsText = "= ? MYSTERY POINTS"
var squidPointsText = "= 30 POINTS"
var crabPointsText = "= 20 POINTS"
var octopusPointsText = "= 10 POINTS"

func _ready() -> void:
	mystery_text_label.text = ""
	squid_text_label.text = ""
	crab_text_label.text = ""
	octopus_text_label.text = ""
	await DrawText(mysteryPointsText, mystery_text_label)
	await DrawText(squidPointsText, squid_text_label)
	await DrawText(crabPointsText, crab_text_label)
	await DrawText(octopusPointsText, octopus_text_label)
	
func DrawText(text: String, label: Label) -> void:
	for s in text:
		label.text += s
		await WaitDrawChar()

func WaitDrawChar() -> void:
	await get_tree().create_timer(charDelay).timeout
