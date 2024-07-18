extends Node

const  SPAWN_RADIUS = 350

@export var basic_enemy_sence: PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = basic_enemy_sence.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position
