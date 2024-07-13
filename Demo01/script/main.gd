extends Node

@export var mob_scene:PackedScene

var score:int

# 游戏结束
func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_geme_over()
	$Music.stop()
	$DeathSound.play()

# 新游戏
func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs","queue_free")
	$Music.play()

# 更新分数
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

# 生成敌人
func _on_mob_timer_timeout() -> void:
	var mob: RigidBody2D = mob_scene.instantiate()
	
	# 生成敌人的路径和方向
	var mob_spawn_location: PathFollow2D = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction: float = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity := Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#将敌人添加到节点树上
	add_child(mob)

# 执行游戏开始的逻辑
func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
	
	
	




