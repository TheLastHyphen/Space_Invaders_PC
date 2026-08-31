extends Area2D

@onready var explode: Sprite2D = $Explode
@onready var missile: Sprite2D = $Missile

var canMove: bool = true
var missileSpeed: float = 750

func _ready() -> void:
	explode.hide()

func _process(delta: float) -> void:
	if canMove:
		position.y -= 1 *delta * missileSpeed

func _on_area_entered(area: Area2D) -> void:
	if area.name == "TopKillZone":
		canMove = false
		missile.hide()
		explode.show()
		await get_tree().create_timer(0.125).timeout
		canMove = true
		#queue_free()
	queue_free()
