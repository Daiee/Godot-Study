extends Node

signal arena_difficulty_increased(area_difficulty: int)

const DIFFICULT_INTERVAL = 5

@export var end_screen_scene: PackedScene

@onready var timer: Timer = $Timer

var area_difficulty: int = 0


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func _process(_delta: float) -> void:
	# 下一个难度增加的时间点(倒数)，剩余时间到达这个时间点，就难度增加,并发出信号等待处理
	var next_target_time: float = timer.wait_time - ((area_difficulty + 1) * DIFFICULT_INTERVAL)
	if timer.time_left <= next_target_time:
		area_difficulty += 1
		arena_difficulty_increased.emit(area_difficulty)


# 获取已经经过的时间(用于UI展示)
func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


# 时间结束，显示胜利画面
func on_timer_timeout() -> void:
	var end_scene_instance = end_screen_scene.instantiate()
	add_child(end_scene_instance)
