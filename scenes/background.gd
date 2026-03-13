extends Node2D

const SCROLL_SPEED = 30
const RESET_X = -1152

func _process(delta: float) -> void:
	translate(Vector2.LEFT * SCROLL_SPEED * delta)
	if position.x <= RESET_X:
		position.x = 0
