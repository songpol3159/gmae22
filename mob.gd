extends RigidBody2D

func _ready():
	# สุ่มอนิเมชันตอนเกิด (มอนสเตอร์จะมี 3 ท่าทางสุ่มกันไป)
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	# เมื่อมอนสเตอร์วิ่งทะลุขอบจอหายไป ให้ลบตัวมันทิ้งเพื่อไม่ให้หนักเครื่อง
	queue_free()
