extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speedMult = 4

func _process(delta: float) -> void:
	velocity = direction * speedMult
	move_and_slide()


func _on_screen_exit() -> void:
	queue_free()
