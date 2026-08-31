extends Node

signal OnTimerTimeOut
signal OnStartGame
signal OnAtEdgeOfScreen
signal OnUpdateScore
signal OnDrawnInvadersComplete
signal OnMoveTimerChange
signal OnPlayerHit
signal OnInvaderKilled
signal OnCheckGameOver
signal OnForceGameOver

func EmitOnForceGameOver() -> void:
	OnForceGameOver.emit()

func EmitOnCheckGameOver() -> void:
	OnCheckGameOver.emit()

func EmitOnInvaderKilled() -> void:
	OnInvaderKilled.emit()

func EmitOnPlayerHit() -> void:
	OnPlayerHit.emit()

func EmitOnMoveTimerChange() -> void:
	OnMoveTimerChange.emit()

func EmitOnDrawnInvadersComplete(totalInvaders: int) -> void:
	OnDrawnInvadersComplete.emit(totalInvaders)

func EmitOnUpdateScore(points: int) -> void:
	OnUpdateScore.emit(points)

func EmitOnAtEdgeOfScreen() -> void:
	OnAtEdgeOfScreen.emit()

func EmitOnTimerTimeOut() -> void:
	OnTimerTimeOut.emit()
	
func EmitOnStartGame() -> void:
	OnStartGame.emit()
