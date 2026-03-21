extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speedMult = 2

func _process(delta: float) -> void:
	velocity = direction * speedMult
	move_and_slide()
