extends Node2D

var bullet = preload("res://Scenes/bullet.tscn")

var bulletSpeed = 250

var canShoot = true

func _process(delta: float) -> void:
	self.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot") && canShoot:
		var x = bullet.instantiate()
		x.global_position = self.global_position
		x.direction = (get_global_mouse_position() - global_position).normalized() * bulletSpeed
		get_tree().current_scene.add_child(x)
		canShoot = false
		$countdownTimer.start()


func _on_countdown_timer_timeout() -> void:
	canShoot = true
