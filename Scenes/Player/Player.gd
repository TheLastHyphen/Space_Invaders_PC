extends Area2D

@export var playerSpeed: float = 500

@onready var player_base: Sprite2D = $PlayerBase
@onready var player_explosion: AnimatedSprite2D = $PlayerExplosion
@onready var player_fire: AudioStreamPlayer2D = $PlayerFire
@onready var demo_move_timer: Timer = $DemoMoveTimer

const PLAYER_MISSILE = preload("uid://vy0it3bcev22")

var canMove: bool = true
var canFire: bool = true
var missile: Area2D

var moveLeft: bool = false
var moveRight: bool = false
var flip: bool = false
var demoFire: bool = false

func _ready() -> void:
	player_explosion.hide()
	SignalHub.OnPlayerHit.connect(OnPlayerHit)
	if States.isDemo == true:
		demo_move_timer.start()
		demoFire = true

func FirePlayerMissile() -> void:
	if missile == null:
		missile = PLAYER_MISSILE.instantiate()
		missile.position = position
		get_parent().add_child(missile)
		if States.isDemo == false:
			player_fire.play()

func _input(event: InputEvent) -> void:
	if event.is_action_type() && States.isDemo:
		States.isDemo = false
		GameManager.LoadMain()
	if demoFire == true && States.isDemo:
		FirePlayerMissile()
		demoFire = false
	
	if event.is_action_pressed("PlayerFire") && canFire && States.isDemo == false:
		FirePlayerMissile()
		#if missile == null:
			#missile = PLAYER_MISSILE.instantiate()
			#missile.position = position
			#get_parent().add_child(missile)
			#if States.isDemo == false:
				#player_fire.play()

func _process(delta: float) -> void:
	if States.isDemo == true:
		if canMove:
			if demoFire: FirePlayerMissile()
			if moveLeft:
				if position.x > 64.0:
					position.x -= delta * playerSpeed
				else:
					moveLeft = false
					moveRight = true
			
			if moveRight:
				if position.x < 1070:
					position.x += delta * playerSpeed
				else:
					moveLeft = true
					moveRight = false
	
	if canMove && States.isDemo == false:
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

func _on_demo_move_timer_timeout() -> void:
	demo_move_timer.stop()
	var random = randf_range(0.25, 2)
	demo_move_timer.wait_time = random
	if flip == true:
		moveRight = true
		moveLeft = false
	if flip == false:
		moveLeft = true
		moveRight = false
	flip = !flip
	demoFire = true
	demo_move_timer.start()
