extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types: PackedStringArray = $AnimatedSprite2D.get_sprite_frames().get_animation_names()
	#随机生成不同的动画['swim', 'walk', 'fly']
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# 释放资源
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
