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
	

## ── Pick a random enemy ─────────────────────────
var shuffled_enemies = []
var enemy_index = 0

func _ready():
	shuffled_enemies = enemies.duplicate()
	shuffled_enemies.shuffle()

func _pick_random_enemy() -> void:
	if shuffled_enemies.is_empty():
		return

	if enemy_index >= shuffled_enemies.size():
		_game_completed()
		return

	var e = shuffled_enemies[enemy_index]
	enemy_index += 1

	enemy_name = e["name"]
	power      = e["power"]
	strength   = e["strength"]
	magic      = e["magic"]
