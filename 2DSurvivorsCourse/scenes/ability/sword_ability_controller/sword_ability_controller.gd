extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene

@onready var timer: Timer = $Timer

var base_wait_time: float


func _ready() -> void:
	base_wait_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy")
	# 过滤距离player > 150 的enemy,distance_squared_to() 比 distance_to 运行速度快
	enemies = enemies.filter(func(enemy: Node2D) -> bool: 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return
	#按照距player的距离进行排序
	enemies.sort_custom(func(a:Node2D, b:Node2D) -> bool:
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_ability.instantiate() as Node2D
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	foreground_layer.add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction: Vector2 = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id != "sword_rate":
		return
	var percent_reduction: float = current_upgrades["sword_rate"]["quantity"] * 0.1
	
	if percent_reduction >= 1:
		percent_reduction = 0.9
	
	timer.wait_time = base_wait_time * (1 - percent_reduction)
	timer.start()
	print(timer.wait_time)
