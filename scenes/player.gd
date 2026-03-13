extends CharacterBody2D

@export var health = 10
@export var speed = 500

const EXPLOSION = preload("res://scenes/explosion.tscn")
const PROJECTILE = preload("res://scenes/projectile.tscn")

@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var screen_rect: Rect2
var is_shooting = false

func _ready():
	add_to_group("player")
	$Area2D.add_to_group("player")
	progress_bar.max_value = health
	progress_bar.value = health
	# Prevent off-screen movement
	var screen_size = get_viewport_rect().size
	var pad_x = 40
	var pad_y = 40
	screen_rect = Rect2(
		Vector2(pad_x, pad_y),
		Vector2(screen_size.x - pad_x * 2, screen_size.y - pad_y * 2)
	)
	animated_sprite.play("idle")

func _process(delta: float) -> void:
	# Handle four directional and diagonal movement
	var move = Input.get_vector("left", "right", "up", "down")
	velocity = move * speed if move else Vector2.ZERO
	move_and_slide()
	# Clamp player within restricted play area
	global_position.x = clamp(global_position.x, screen_rect.position.x, screen_rect.end.x)
	global_position.y = clamp(global_position.y, screen_rect.position.y, screen_rect.end.y)
	# Shoot on accept input
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	# Prevent shooting until current animation finishes
	if is_shooting:
		return
	is_shooting = true
	animated_sprite.play("shoot")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = global_position
	add_sibling(new_projectile)
	await animated_sprite.animation_finished
	animated_sprite.play("idle")
	is_shooting = false

func take_damage():
	# Reduce health and update health bar
	health -= 1
	progress_bar.value = health
	if health <= 0:
		explode()

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Take damage on contact with enemy
	if area.is_in_group("enemy"):
		take_damage()

func explode():
	# Spawn large explosion then remove player from scene
	var explosion = EXPLOSION.instantiate()
	explosion.explosion_scale = 3.0
	explosion.global_position = global_position
	add_sibling(explosion)
	queue_free()
