extends Area2D

@export var bullet_speed : float
var direction : float = 1.0

func _ready() -> void:
	# 子弹在生成6秒后消失
	await get_tree().create_timer(6).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	# 子弹的移动速度
	position += Vector2(bullet_speed * direction, 0) * delta
