extends Node

@export var end_screen_scene: PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func get_time_elapsed() -> float:
	return $Timer.wait_time - $Timer.time_left


func on_timer_timeout() -> void:
	var end_scene_instance = end_screen_scene.instantiate()
	add_child(end_scene_instance)
