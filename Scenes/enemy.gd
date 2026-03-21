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


## ── Pick a random enemy ─────────────────────────
var enemies = []
var shuffled_enemies = []
var enemy_index = 0


func _ready():
	shuffled_enemies = enemies.duplicate()
	shuffled_enemies.shuffle()

func _pick_random_enemy() -> void:
	if shuffled_enemies.is_empty():
		return

	if enemy_index >= shuffled_enemies.size():
		#_game_completed()
		return

	var e = shuffled_enemies[enemy_index]
	enemy_index += 1

	var enemy_name = e["name"]
	var power      = e["power"]
	var strength   = e["strength"]
	var magic      = e["magic"]
