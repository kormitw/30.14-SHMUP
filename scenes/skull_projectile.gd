extends Area2D

const EXPLOSION = preload("res://scenes/explosion.tscn")

var speed = 300

func _ready():
	add_to_group("enemy_projectile")

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	if global_position.x < -50:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var player = area.get_parent()
		if player.has_method("take_damage"):
			player.take_damage()
		# small explosion on impact
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
