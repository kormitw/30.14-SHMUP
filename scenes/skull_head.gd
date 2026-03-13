extends Area2D

const EXPLOSION = preload("res://scenes/explosion.tscn")
const HIT = preload("res://scenes/hit.tscn")
const PROJECTILE = preload("res://scenes/skull_projectile.tscn")

var health = 5
var speed = randf_range(80, 150)
var amplitude = randf_range(1, 4)
var frequency = randf_range(1, 3)
var vertical_drift = randf_range(-30, 30)

func _ready():
	add_to_group("enemy")

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	position.y += sin(position.x * frequency * delta) * amplitude + vertical_drift * delta
	if global_position.x < -100:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.queue_free()
		health -= 1
		if health <= 0:
			explode()
		else:
			hit()
	elif area.is_in_group("player"):
		var player = area.get_parent()
		if player.has_method("take_damage"):
			player.take_damage()
		health -= 1
		if health <= 0:
			explode()
		else:
			hit()

func explode():
	var explosion = EXPLOSION.instantiate()
	explosion.explosion_scale = 3.0
	explosion.global_position = global_position
	add_sibling(explosion)
	queue_free()

func hit():
	var hitmark = HIT.instantiate()
	hitmark.position = Vector2.ZERO
	add_child(hitmark)

func _on_shoot_timer_timeout() -> void:
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = global_position
	add_sibling(new_projectile)
