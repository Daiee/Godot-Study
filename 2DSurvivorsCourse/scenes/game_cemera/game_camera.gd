extends Camera2D

var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acquire_target()
	self.global_position = self.global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func acquire_target() -> void:
	var player_nodes: Array[Node] = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position

