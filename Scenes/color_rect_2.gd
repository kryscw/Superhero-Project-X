extends ColorRect


func _on_mouse_entered() -> void:
	print("enter")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.5)


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.25, 0.5)
