extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOTHING = 25

func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	
	# 获得一个移动方向的单位向量，相当于适配了各个方向，不再局限于上下左右四个方向
	var direction: Vector2 = movement_vector.normalized()
	var target_velocity: Vector2 = direction * MAX_SPEED
	self.velocity = self.velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOTHING)) 
	move_and_slide()


func get_movement_vector() -> Vector2:
	# get_axis()是简写
	# var x_vector = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var x_vector: float = Input.get_axis("move_left", "move_right")
	var y_vector: float = Input.get_axis("move_up", "move_down")
	return Vector2(x_vector, y_vector)
