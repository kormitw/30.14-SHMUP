extends Node2D

const SCROLL_SPEED = 30
const RESET_X = -1152

func _process(delta: float) -> void:
	# Scroll background left continuously
	translate(Vector2.LEFT * SCROLL_SPEED * delta)
	# Reset position to create seamless loop
	if position.x <= RESET_X:
		position.x = 0
