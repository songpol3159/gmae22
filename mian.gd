extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func _on_player_hit():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free") # ล้างมอนสเตอร์เก่าออกให้หมด
	$Music.play()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	# 1. สร้างมอนสเตอร์ตัวใหม่ขึ้นมาตัวนึง
	var mob = mob_scene.instantiate()

	# 2. สุ่มจุดเกิดตามเส้นรอบขอบหน้าจอ (MobPath)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# 3. ตั้งทิศทางให้หันหน้าเข้าหาหน้าจอเกม
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position

	# 4. สุ่มมุมเบี่ยงเบนอีกนิดหน่อยเพื่อไม่ให้มอนสเตอร์วิ่งทื่อเกินไป
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# 5. สุ่มความเร็วในการวิ่งของมอนสเตอร์ตัวนั้น
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# 6. เพิ่มมอนสเตอร์ลงไปในหน้าจอเกม
	add_child(mob)


func _on_hud_start_game() -> void:
	new_game()
