extends Node2D

const INVADER_SQUID = preload("uid://bqylkd1b7vsoo")
const INVADER_OCTOPUS = preload("uid://bju7hg7rsgfsk")
const INVADER_CRAB = preload("uid://c2yu0o6jny8ml")
const row1StartPosition: Vector2 = Vector2(33, 90)
const row2StartPosition: Vector2 = Vector2(33, 120)
const row3StartPosition: Vector2 = Vector2(33, 150)
const row4StartPosition: Vector2 = Vector2(33, 180)
const row5StartPosition: Vector2 = Vector2(33, 210)
const invaderXSpacing: float = 50
const invaderYSpacing: float = 50
const numberOfInvadersInRow = 20

var totalInvaders: int = 0
var frame: int = 0;

func SetupInvaders() -> void:
	totalInvaders = 0
	await  SetupRow5()
	await  SetupRow4()
	await  SetupRow3()
	await  SetupRow2()
	await  SetupRow1()
	SignalHub.EmitOnDrawnInvadersComplete(totalInvaders)

func SetupRow1() -> void:
	for i in range(numberOfInvadersInRow):
		var invader = INVADER_SQUID.instantiate()
		invader.position = Vector2(row1StartPosition.x + (invaderXSpacing * i), row1StartPosition.y)
		invader.can_auto_translate()
		add_child(invader)
		invader.invader_move_anim.modulate = Color(255,10,10,255)
		await  WaitDrawInvader()
	totalInvaders += numberOfInvadersInRow

func SetupRow2() -> void:
	for i in range(numberOfInvadersInRow):
		var invader = INVADER_CRAB.instantiate()
		invader.position = Vector2(row2StartPosition.x + (invaderXSpacing * i), row2StartPosition.y)
		add_child(invader)
		invader.invader_move_anim.modulate = Color(0,255,0,255)
		await  WaitDrawInvader()
	totalInvaders += numberOfInvadersInRow

func SetupRow3() -> void:
	for i in range(numberOfInvadersInRow):
		var invader = INVADER_CRAB.instantiate()
		invader.position = Vector2(row3StartPosition.x + (invaderXSpacing * i), row3StartPosition.y)
		add_child(invader)
		invader.invader_move_anim.modulate = Color(0,10,255,255)
		await  WaitDrawInvader()
	totalInvaders += numberOfInvadersInRow

func SetupRow4() -> void:
	for i in range(numberOfInvadersInRow):
		var invader = INVADER_OCTOPUS.instantiate()
		invader.position = Vector2(row4StartPosition.x + (invaderXSpacing * i), row4StartPosition.y)
		add_child(invader)
		invader.invader_move_anim.modulate = Color(0.3,0.1,0.31,255)
		await  WaitDrawInvader()
	totalInvaders += numberOfInvadersInRow
	
func SetupRow5() -> void:
	for i in range(numberOfInvadersInRow):
		var invader = INVADER_OCTOPUS.instantiate()
		invader.position = Vector2(row5StartPosition.x + (invaderXSpacing * i), row5StartPosition.y)
		add_child(invader)
		invader.invader_move_anim.modulate = Color(255,5,50,255)
		await  WaitDrawInvader()
	totalInvaders += numberOfInvadersInRow
		
func WaitDrawInvader() -> void:
	await get_tree().create_timer(0.001).timeout
