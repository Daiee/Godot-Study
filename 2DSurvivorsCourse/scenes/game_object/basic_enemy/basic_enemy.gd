extends CharacterBody2D

const MAX_SPEED = 50 


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func _process(_delta: float) -> void:
	var direction: Vector2 = get_player_direction() # 方向
	self.velocity = direction * MAX_SPEED
	move_and_slide()


# 返回接近玩家的方向向量,length = 0
func get_player_direction() -> Vector2:
	# get_first_node_in_group(),获取数组中的第一个元素
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO


func on_area_entered(_area: Area2D) -> void:
	queue_free()
