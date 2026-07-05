extends CanvasLayer

# ส่งสัญญาณบอกตัวเกมหลัก (Main) ว่าปุ่มเริ่มเกมโดนกดแล้วนะ
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# รอจนกว่า MessageTimer (2 วินาที) จะทำงานเสร็จ
	await $MessageTimer.timeout

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	# หน่วงเวลาแปปนึงค่อยโผล่ปุ่ม Start ขึ้นมาใหม่
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide() # กดแล้วซ่อนปุ่มไป
	$StudentIDLabel.hide()
	start_game.emit() # ส่งสัญญาณเริ่มเกม

func _on_message_timer_timeout():
	$Message.hide() # พอครบ 2 วินาที ให้ซ่อนข้อความไป
