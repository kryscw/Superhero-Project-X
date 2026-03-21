extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Player")
var speed = 200.0

func _process(delta: float) -> void:
	velocity = (player.global_position - global_position).normalized() * speed
	velocity.y += 800
	
	move_and_slide()
	


func _on_damage_area_hit(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("AHHHH!")
	## TODO (SUMIT) - lose health
