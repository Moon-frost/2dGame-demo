extends CharacterBody2D

@export var move_speed : float
@export var animator : AnimatedSprite2D

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * move_speed
	move_and_slide()

	if velocity == Vector2.ZERO :
		animator.play("idle")
	else :
		animator.play("run")
