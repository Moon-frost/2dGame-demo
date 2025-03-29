extends Area2D

@export var slime_speed : float
@export var animation : AnimatedSprite2D
var direction : int
var is_bead : bool = false

func _ready():
	# 假设屏幕宽度为 1280，中心为 640
	var screen_center = 584.0
	# 根据初始位置决定移动方向
	if position.x < screen_center:
		direction = -1.0  # 从左向右
		animation.flip_h = true
	else:
		direction = 1.0  # 从右向左

func _physics_process(delta: float) -> void:
	# 检测怪物未死亡时进行移动
	if not is_bead:
		position += Vector2 (slime_speed * direction, 0) * delta
	
	# 移动到该位置自动销毁
	if position.x < -120 or position.x > 1232:
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
		# 分数增加
		get_tree().current_scene.score += 1
		# 播放动画和死亡音效，销毁
		animation.play("dead")
		$DeathSound.play()
		await animation.animation_finished
		queue_free()
