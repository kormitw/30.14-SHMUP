extends Node2D

const SKULL = preload("res://scenes/skull_head.tscn")

@onready var spawn_timer: Timer = $SpawnTimer

var screen_size: Vector2

func _ready():
	# Store screen size for spawn position calculations
	screen_size = get_viewport_rect().size

func _on_spawn_timer_timeout():
	# Spawn skull just off the right edge at a random height
	var skull = SKULL.instantiate()
	skull.global_position = Vector2(screen_size.x + 50, randf_range(50, screen_size.y - 50))
	add_child(skull)

func _on_timer_timeout() -> void:
	pass
