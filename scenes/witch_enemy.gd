extends Area2D
const EXPLOSION = preload("res://scenes/explosion.tscn")

var health = 5
var speed = 100

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	position.y += sin(position.x * delta) * 2


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		health -= 1
		if health == 0:
			explode()
		

func explode():
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
