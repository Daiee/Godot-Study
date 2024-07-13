extends CanvasLayer

signal start_game

# 用于控制屏幕上文字的显示及显示时间
func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# 游戏结束时调用
func show_geme_over() -> void:
	show_message("game over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	# 运行时创建一个Timer节点，持续1s后显示"游戏开始按钮"
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

# 更新分数
func update_score(score) -> void:
	$Scorelabel.text = str(score)

# 游戏开始
func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

# Timer结束后隐藏文字
func _on_message_timer_timeout() -> void:
	$Message.hide()
