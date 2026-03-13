extends Area2D
const EXPLOSION = preload("res://scenes/explosion.tscn")
const HIT = preload("res://scenes/hit.tscn")

var health = 5
var speed = 100

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	position.y += sin(position.x * delta) * 2


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile") or area.is_in_group("player"):
		area.queue_free()
		if health == 0:
			explode()
		else:
			health -= 1
			hit()
		

func explode():
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()

func hit():
	var hitmark = HIT.instantiate()
	hitmark.position = Vector2.ZERO
	add_child(hitmark)
