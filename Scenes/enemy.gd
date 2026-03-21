extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Player")
var speed = 200.0
var health = 100
var damage = 25

func _process(delta: float) -> void:
	$healthBar.value = health
	velocity = (player.global_position - global_position).normalized() * speed
	velocity.y += 800
	move_and_slide()
	if health <= 0:
		queue_free()

func _on_damage_area_hit(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is CharacterBody2D && body != player && body != self:
		body.queue_free()
		health -= damage
