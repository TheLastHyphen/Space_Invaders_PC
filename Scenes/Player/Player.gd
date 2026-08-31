extends Area2D

@export var playerSpeed: float = 500

@onready var player_base: Sprite2D = $PlayerBase
@onready var player_explosion: AnimatedSprite2D = $PlayerExplosion

const PLAYER_MISSILE = preload("uid://vy0it3bcev22")

var canMove: bool = true
var canFire: bool = true
var missile: Area2D

func _ready() -> void:
	player_explosion.hide()
	SignalHub.OnPlayerHit.connect(OnPlayerHit)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PlayerFire") && canFire:
		if missile == null:
			missile = PLAYER_MISSILE.instantiate()
			missile.position = position
			get_parent().add_child(missile)

func _process(delta: float) -> void:
	if canMove:
		var vpr: Rect2 = get_viewport_rect()
		var dir: float = Input.get_axis("PlayerLeft", "PlayerRight")
		position.x += dir * delta * playerSpeed
		
		if position.x > vpr.end.x - player_base.texture.get_size().x - (50.0):
			position.x = vpr.end.x - player_base.texture.get_size().x - (50.0)

		if position.x < vpr.position.x + player_base.texture.get_size().x + 50.0:
			position.x = vpr.position.x + player_base.texture.get_size().x + 50.0

func OnPlayerHit() -> void:
	canMove = false
	canFire = false
	player_base.hide()
	player_explosion.show()
	player_explosion.play()

func _on_player_explosion_finished() -> void:
	SignalHub.EmitOnCheckGameOver()
	player_explosion.hide()
	player_base.show()
	canMove = true
	canFire = true
