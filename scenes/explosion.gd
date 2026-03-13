extends AnimatedSprite2D

var explosion_scale = 1.0

func _ready():
	# Set explosion size then play animation
	scale = Vector2(explosion_scale, explosion_scale)
	play("explode")

func _on_animation_finished():
	# Remove from scene once animation completes
	queue_free()
