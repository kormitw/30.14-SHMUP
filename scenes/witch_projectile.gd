extends Area2D

var speed = 150

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
