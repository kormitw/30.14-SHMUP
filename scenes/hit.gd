extends AnimatedSprite2D

func _ready():
	# Wait for animation to finish then remove from scene
	await animation_finished
	queue_free()

func _on_animation_finished() -> void:
	pass
