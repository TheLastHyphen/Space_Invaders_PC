extends Area2D

@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var show_score: Timer = $ShowScore
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var startPosition: Vector2
var shipSpeed: float = 125
var scores: Array[int] = [ 50, 100, 150, 200, 250, 300, 350 ]
var hit: bool = false

func _ready() -> void:
	hit = false

func _process(delta: float) -> void:
	if hit == false:
		position.x += 1 * shipSpeed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.name == "RightKillZone":
		queue_free()
		return
	if area.name == "PlayerMissile":
		hit = true
		area.free()
		sprite_2d.hide()
		collision_shape_2d.free()
		var score = scores[randi_range(0, 6)]
		show_score.start()
		SignalHub.EmitOnUpdateScore(score)
		label.text = "%d" % score

func _on_show_score_timeout() -> void:
	queue_free()
