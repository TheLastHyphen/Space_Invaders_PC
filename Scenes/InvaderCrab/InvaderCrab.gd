class_name InvaderCrab
extends Invader

@onready var invader_explode: AnimatedSprite2D = $InvaderExplode

const bombDropChance: float = .015
const points: int = 20
const delayBombDrop: int = 5

var delayBomgDropCount = 0;
var invBomb: Area2D
var bombDropSpeed: int = 100

func _on_bomb_drop_timeout() -> void:
	delayBomgDropCount += 1
	if delayBomgDropCount < delayBombDrop: return
	var dropChance: float = randf()
	if dropChance < bombDropChance && invBomb == null:
		invBomb = INVADER_BOMB_2.instantiate()
		invBomb.position = position
		get_parent().add_child(invBomb)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "BottomKillZone" || area.name == "Player":
		canMove = false
		SignalHub.EmitOnPlayerHit()
		await get_tree().create_timer(2).timeout
		SignalHub.EmitOnForceGameOver()
	elif area.name != "RightScreen" && area.name != "LeftScreen":
		SignalHub.EmitOnUpdateScore(points)
		invader_move_anim.hide()
		invader_explode.show()
		invader_explode.play()

func _on_invader_explode_animation_finished() -> void:
	SignalHub.EmitOnMoveTimerChange()
	SignalHub.EmitOnInvaderKilled()
	queue_free()

#func _on_animated_sprite_2d_2_animation_finished() -> void:
	#SignalHub.EmitOnMoveTimerChange()
	#SignalHub.EmitOnInvaderKilled()
	#queue_free()
