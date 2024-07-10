extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_geme_over():
	show_message("game over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$Scorelabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
