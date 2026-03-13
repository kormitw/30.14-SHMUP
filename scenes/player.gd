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
	var screen_size = get_viewport_rect().size
	var radius = $CollisionShape2D.shape.radius
	var half = Vector2(radius, radius)
	screen_rect = Rect2(half, screen_size - half)
	animated_sprite.play("idle")

func _process(delta: float) -> void:
	var move = Input.get_vector("left", "right", "up", "down")
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	global_position.x = clamp(global_position.x, screen_rect.position.x, screen_rect.end.x)
	global_position.y = clamp(global_position.y, screen_rect.position.y, screen_rect.end.y)
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
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
	health -= 1
	progress_bar.value = health
	if health <= 0:
		explode()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		take_damage()

func explode():
	var explosion = EXPLOSION.instantiate()
	explosion.explosion_scale = 3.0
	explosion.global_position = global_position
	add_sibling(explosion)
	queue_free()
