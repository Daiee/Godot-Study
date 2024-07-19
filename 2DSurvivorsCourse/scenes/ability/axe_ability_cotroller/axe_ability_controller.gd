extends Node

@export var axe_ability: PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)

## 时间结束生成Axe
## 信号发起： axe_ability_controller
## 信号处理： axe_ability_controller
func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
	
	var axe_instance := axe_ability.instantiate()
	foreground.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	
