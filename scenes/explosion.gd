extends AnimatedSprite2D

var explosion_scale = 1.0

func _ready():
	scale = Vector2(explosion_scale, explosion_scale)
	play("explode")

func _on_animation_finished():
	queue_free()
