extends Node2D

@export var slimer_sence : PackedScene
@export var spawn_timer : Timer
@export var score_label : Label
@export var game_over_label : Label

var score : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer.wait_time -= 0.2 * delta
	spawn_timer.wait_time = clamp(spawn_timer.wait_time, 0.5, 3)
	
	score_label.text = "Score: " + str(score)

func _spawn_slime() -> void:
	var slimer_node = slimer_sence.instantiate()
	slimer_node.position = Vector2(1158, randf_range(468, 600))
	get_tree().current_scene.add_child(slimer_node)

func show_game_over():
	game_over_label.visible = true
