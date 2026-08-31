extends Node

@onready var timer: Timer = $MoveTimer
@onready var left_screen: Area2D = $LeftScreen
@onready var right_screen: Area2D = $RightScreen
@onready var level: Node2D = $Level
@onready var lives: Node2D = $Lives
@onready var lives_remain: Label = $LivesRemain
@onready var player: Area2D = $Player

const SPACE_SHIP = preload("uid://dt74v7u3ed1qu")
const GAME_OVER = preload("uid://3p1e75h0ngdi")

var spaceShip: Area2D;
var spaceShipAppearChance: float = 0.02
var score: int = 0
var movementTimer: float = 1.0
var movementTimerStep: float = 0;

var TotalInvadersLeft: int:
	get: return TotalInvadersLeft
	set(value): TotalInvadersLeft = value

func _ready() -> void:
	lives_remain.text = str(lives.RemainingLives)
	player.canFire = false
	level.SetupInvaders()
	SignalHub.OnUpdateScore.connect(OnUpdateScore)
	SignalHub.OnDrawnInvadersComplete.connect(OnDrawnInvadersComplete)
	SignalHub.OnMoveTimerChange.connect(OnMoveTimerChange)
	SignalHub.OnInvaderKilled.connect(OnInvaderKilled)
	SignalHub.OnCheckGameOver.connect(OnCheckGameOver)
	SignalHub.OnForceGameOver.connect(OnForceGameOver)

func OnInvaderKilled() -> void:
	TotalInvadersLeft -= 1
	print("Invaders left: ", TotalInvadersLeft)
	if TotalInvadersLeft == 0:
		player.canFire = false
		timer.wait_time = 1.0
		timer.stop()
		movementTimer = 1.0
		level.SetupInvaders()

func OnForceGameOver() -> void:
	EndGame()

func OnCheckGameOver() -> void:
	lives.UpdateLives()
	if lives.RemainingLives == 0:
		EndGame()
	lives_remain.text = str(lives.RemainingLives)

func EndGame() -> void:
	player.hide()
	lives_remain.text = str(lives.RemainingLives)
	get_tree().paused = true
	add_child(GAME_OVER.instantiate())
	await get_tree().create_timer(5.0).timeout
	GameManager.LoadMain()

func OnMoveTimerChange() -> void:
	movementTimer -= movementTimerStep
	if movementTimer < 0: movementTimer = 0.005
	timer.wait_time = movementTimer

func OnDrawnInvadersComplete(totalInvaders: int) -> void:
	TotalInvadersLeft = totalInvaders
	player.canFire = true
	movementTimerStep = movementTimer / TotalInvadersLeft
	print("Total invaders: ", totalInvaders)
	timer.start()

func OnUpdateScore(points: int) -> void:
	score += points
	ScoreDisplay.UpdateScores(score)

func _on_timer_timeout() -> void:
	SignalHub.EmitOnTimerTimeOut()

func _on_left_screen_area_entered(_area: Area2D) -> void:
	left_screen.disconnect("area_entered", _on_left_screen_area_entered)
	SignalHub.EmitOnAtEdgeOfScreen()
	left_screen.connect("area_entered", _on_left_screen_area_entered)

func _on_right_screen_area_entered(_area: Area2D) -> void:
	right_screen.disconnect("area_entered", _on_right_screen_area_entered)
	SignalHub.EmitOnAtEdgeOfScreen()
	right_screen.connect("area_entered", _on_right_screen_area_entered)

func _on_top_kill_zone_area_entered(area: Area2D) -> void:
	area.queue_free()
	
func _on_space_ship_spawn_timer_timeout() -> void:
	var random = randf_range(0.1, 0.01)
	if spaceShip == null && random < spaceShipAppearChance:
		spaceShip = SPACE_SHIP.instantiate()
		spaceShip.position = Vector2(-50, 80)
		add_child(spaceShip)

# used to kill spaceShip
func _on_right_kill_zone_area_entered(area: Area2D) -> void:
	area.queue_free()
