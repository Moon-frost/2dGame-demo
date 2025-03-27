extends Area2D

@export var slime_speed : float
@export var animation : AnimatedSprite2D
var is_bead : bool = false

func _physics_process(delta: float) -> void:
	if not is_bead:
		position += Vector2 (slime_speed, 0) * delta
	
	if position.x < -267:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.game_over()
	


func _on_bullet_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		animation.play("dead")
		is_bead = true
		area.queue_free()
		get_tree().current_scene.score += 1
		await get_tree().create_timer(0.6).timeout
		queue_free()
