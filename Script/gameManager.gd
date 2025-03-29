extends Node2D

@export var slimer_scene : PackedScene
@export var spawn_timer : Timer
@export var score_label : Label
@export var game_over_label : Label

var score : int = 0

func _process(delta: float) -> void:
	# 怪物生成机制
	spawn_timer.wait_time -= 0.2 * delta
	spawn_timer.wait_time = clamp(spawn_timer.wait_time, 0.5, 3)
	
	# 记分UI
	score_label.text = "Score: " + str(score)

func _spawn_slime() -> void:
	# 创建左右生成随机数
	var spawn_enemy_x = [1158, -16]
	var random_x = spawn_enemy_x[randi() % spawn_enemy_x.size()]
	# 预加载史莱姆场景
	var slimer_node = slimer_scene.instantiate()
	# 定义史莱姆在场景中的位置
	slimer_node.position = Vector2(random_x, randf_range(468, 600))
	# 生成史莱姆
	get_tree().current_scene.add_child(slimer_node)

func show_game_over():
	# 弹出游戏结束
	game_over_label.visible = true
