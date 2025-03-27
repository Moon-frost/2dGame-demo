extends Area2D

@export var slime_speed : float
@export var animation : AnimatedSprite2D
var is_bead : bool = false

func _physics_process(delta: float) -> void:
	# 检测怪物未死亡时进行移动
	if not is_bead:
		position += Vector2 (slime_speed, 0) * delta
	
	# 移动到该位置自动销毁
	if position.x < -267:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	# 当玩家触碰到后，游戏结束
	if body is CharacterBody2D and not is_bead:
		body.game_over()
	


func _on_bullet_entered(area: Area2D) -> void:
	# 检测是否有子弹碰撞
	if area.is_in_group("bullet"):
		# 先销毁子弹
		area.queue_free()
		# 如果怪物已经死亡，直接返回
		if is_bead:
			return
		# 设置怪物死亡状态
		is_bead = true
		get_tree().current_scene.score += 1
		animation.play("dead")
		$DeathSound.play()
		await animation.animation_finished
		queue_free()
