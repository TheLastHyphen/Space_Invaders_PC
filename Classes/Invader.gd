class_name Invader

extends Node2D

@onready var invader_move_anim: AnimatedSprite2D = $AnimatedSprite2D

const INVADER_BOMB_1 = preload("uid://c7lu22a8t2cwu")
const INVADER_BOMB_2 = preload("uid://db7gystd3v18m")

var direction: int = 1
var droppingDown: bool = false
var canMove = true

func _ready() -> void:
	SignalHub.OnTimerTimeOut.connect(OnTimerTimeOut)
	SignalHub.OnAtEdgeOfScreen.connect(OnAtEdgeOfScreen)

func OnTimerTimeOut() -> void:
	if droppingDown == false:
		Move()
	if droppingDown == true:
		position.y += 20
		direction *= -1
		droppingDown = false

func OnAtEdgeOfScreen() -> void: 
	droppingDown = true

func Move() -> void:
	if canMove:
		position.x += 15 * direction
		if invader_move_anim.frame == 1:
			invader_move_anim.frame = 0
		elif invader_move_anim.frame == 0:
			invader_move_anim.frame = 1
