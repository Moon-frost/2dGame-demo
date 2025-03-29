extends CharacterBody2D

@export var move_speed : float = 100
@export var animator : AnimatedSprite2D
@export var bullet_scene : PackedScene
@export var shot_cooldown : float
var is_game_over : bool = false
var face_direction : bool = true
var can_fire : bool = true
var is_rolling : bool = false

func _process(delta: float) -> void:
	# 根据速度或游戏是否结束来控制跑步音效
	if velocity == Vector2.ZERO or is_game_over:
		$RunningSound.stop()
	elif not $RunningSound.playing:
		$RunningSound.play()
		

func _physics_process(delta: float) -> void:
	# 角色移动
	if is_game_over == false:
		velocity = Input.get_vector("left", "right", "up", "down") * move_speed
		if is_rolling:
			velocity = Vector2(move_speed * (1 if face_direction else -1), 0) * 2
		move_and_slide()
		
		if not is_rolling:
			# 根据速度判断状态，并播放相应动画
			if velocity ==  Vector2.ZERO :
				animator.play("idle")
			else :
				animator.play("run")
			
				if velocity.x > 0 :
					face_direction = true
					animator.flip_h = false
				elif velocity.x < 0:
					face_direction = false
					animator.flip_h = true
		
	if Input.is_action_pressed("shot"):
		# 游戏结束时，停止射击
		if is_game_over:
			return
		if can_fire == true:
			# 射击音效
			$FireSound.play()
			
			# 子弹发射方向
			var bullet_node = bullet_scene.instantiate()
			if face_direction == true:
				bullet_node.position = position + Vector2(6, 6)
				bullet_node.direction = 1.0
			else:
				bullet_node.position = position + Vector2(-6, 6)
				bullet_node.direction = -1.0
			get_tree().current_scene.add_child(bullet_node)
			can_fire = false
			await get_tree().create_timer(shot_cooldown).timeout
			can_fire = true

func game_over():
	if not is_game_over:
		is_game_over = true
		# 播放游戏结束音效
		$GameOver.play()
		# 调用主场景中游戏结束动画
		get_tree().current_scene.show_game_over()
		# 播放角色游戏结束动画
		animator.play("game_over")

		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(load("res://Scense/Menu.tscn"))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rolling"):
		is_rolling = true
		$CollisionShape2D.disabled = true
		animator.play("rolling")
		await animator.animation_finished
		is_rolling = false
		$CollisionShape2D.disabled = false
		
