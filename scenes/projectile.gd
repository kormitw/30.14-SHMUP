extends Area2D

var speed = 500

func _ready():
	add_to_group("Projectile")

func _process(delta: float) -> void:
	translate(Vector2.RIGHT * speed * delta)
	if global_position.x > get_viewport_rect().size.x + 50:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()
