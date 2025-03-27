extends Node2D

@export var slimer_sence : PackedScene
@export var spawn_timer : Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer.wait_time -= 0.2 * delta
	spawn_timer.wait_time = clamp(spawn_timer.wait_time, 0.5, 3)

func _spawn_slime() -> void:
	var slimer_node = slimer_sence.instantiate()
	slimer_node.position = Vector2(266, randf_range(56, 108))
	get_tree().current_scene.add_child(slimer_node)
