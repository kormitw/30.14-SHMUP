extends Area2D

const EXPLOSION = preload("res://scenes/explosion.tscn")

var speed = 500

func _ready():
	# Add to group so enemies can detect this as a projectile
	add_to_group("Projectile")

func _process(delta: float) -> void:
	# Move projectile to the right
	translate(Vector2.RIGHT * speed * delta)
	# Remove when off the right edge of screen
	if global_position.x > get_viewport_rect().size.x + 50:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		# Spawn small explosion at impact point then remove projectile
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
