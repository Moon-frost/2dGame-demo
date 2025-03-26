extends Area2D

@export var bullet_speed : float

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += Vector2(bullet_speed, 0) * delta
