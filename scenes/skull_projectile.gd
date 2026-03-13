extends Area2D

const EXPLOSION = preload("res://scenes/explosion.tscn")

var speed = 300

func _ready():
	# Add to group so player can detect this as an enemy projectile
	add_to_group("enemy_projectile")

func _process(delta: float) -> void:
	# Move projectile to the left
	translate(Vector2.LEFT * speed * delta)
	# Remove when off the left edge of screen
	if global_position.x < -50:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		# Deal damage to player on contact
		var player = area.get_parent()
		if player.has_method("take_damage"):
			player.take_damage()
		# Spawn small explosion on impact then remove projectile
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
