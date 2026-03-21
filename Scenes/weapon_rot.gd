extends Node2D

var bullet = preload("res://Scenes/bullet.tscn")

func _process(delta: float) -> void:
	self.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("shoot"):
		var x = bullet.instantiate()
		x.global_position = self.global_position
		x.direction = get_global_mouse_position() - global_position
		get_tree().current_scene.add_child(x)
