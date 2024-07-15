extends CharacterBody2D

const MAX_SPEED = 40 

@onready var health_component: HealthComponent = $HealthComponent


func _process(_delta: float) -> void:
	var direction: Vector2 = get_player_direction() # 方向O
	self.velocity = direction * MAX_SPEED
	move_and_slide()


# 返回接近玩家的方向向量,length = 0
func get_player_direction() -> Vector2:
	# get_first_node_in_group(),获取数组中的第一个元素
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
