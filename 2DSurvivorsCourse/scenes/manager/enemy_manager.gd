extends Node

const  SPAWN_RADIUS = 350

@export var basic_enemy_sence: PackedScene
@export var arena_time_manager: Node

@onready var timer: Timer = $Timer

var base_spawn_time: float = 0


func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_spawn_position() -> Vector2:
	# 获取怪物生成的圆心：player
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	
	# 半径350的圆上随机产生怪物出生点,如果出生点在地图外，将方向旋转90，最多旋转4次
	var spawn_position := Vector2.ZERO
	var random_direction := Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var query_paramaters := PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result:Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position



## 时间结束怪物生成
## 信号发起： arena_time_manager
## 信号处理： enemy_manager
func on_timer_timeout() -> void:
	timer.start()


	# 将出生的怪物实例化并加入节点树
	var enemy = basic_enemy_sence.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


## 难度增长增加敌人的生成速度
## 信号发起： arena_time_manager
## 信号处理： enemy_manager
func on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off: float = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
