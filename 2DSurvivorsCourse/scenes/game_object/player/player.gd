extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOTHING = 25

@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar

var colliding_bodies_number: int = 0


func _ready() -> void:
	$CollisionArea2D.body_entered.connect(on_body_enterd)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	update_health_display()


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


func check_deal_damage() -> void:
	if colliding_bodies_number == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()


func on_body_enterd(_other_body: Node2D) -> void:
	colliding_bodies_number += 1
	check_deal_damage()


func on_body_exited(_other_body: Node2D) -> void:
	colliding_bodies_number -= 1


func on_damage_interval_timer_timeout() -> void:
	check_deal_damage()


func on_health_changed() -> void:
	update_health_display()
