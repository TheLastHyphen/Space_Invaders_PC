class_name InvaderBomb1
extends Area2D

@onready var explode: Sprite2D = $Explode
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var bombDropSpeed: int = 100
var points: int = 1
var isExplode: bool = false

func _ready() -> void:
	explode.hide()
	bombDropSpeed = randi_range(75, 200)

func _process(delta: float) -> void:
	if(isExplode == false):
		position.y += bombDropSpeed * delta

func _on_area_entered(area: Area2D) -> void:
	self.disconnect("area_entered", _on_area_entered)
	isExplode = true
	if area.name == "PlayerMissile":
		SignalHub.EmitOnUpdateScore(points)
	elif area.name == "Player":
		SignalHub.EmitOnPlayerHit()
	animated_sprite_2d.hide()
	explode.show()
	await get_tree().create_timer(.125).timeout
	queue_free()
