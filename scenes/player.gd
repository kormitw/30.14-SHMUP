extends CharacterBody2D

@export var health = 10
@export var speed = 500
const PROJECTILE = preload("res://scenes/projectile.tscn")
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar
@onready var shoot_timer: Timer = $shootTimer

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health

func _process(delta: float) -> void:
	var move = Input.get_vector("left","right","up","down")
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = global_position
	add_sibling(new_projectile)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		health -= 1
		area.explode()
		progress_bar.value = health
