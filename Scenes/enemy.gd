extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Player")
var speed = 200.0
var maxHealth = 100
var health = maxHealth
var damage = 25
var damageDealing = 25
var enemy_name
var power
var strength
var magic
var hometown

func _process(delta: float) -> void:
	$healthBar.value = remap(health, 0, maxHealth, 0.0, 100)
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
var enemies = superIndex.villains
var shuffled_enemies = []
var enemy_index = 0


func _ready():
	shuffled_enemies = enemies.duplicate()
	shuffled_enemies.shuffle()
	_pick_random_enemy()

func _pick_random_enemy() -> void:
	if shuffled_enemies.is_empty():
		return

	if enemy_index >= shuffled_enemies.size():
		#_game_completed()
		return

	var e = shuffled_enemies[enemy_index]
	enemy_index += 1

	enemy_name = e["name"]
	power = e["power"]
	strength = e["strength"]
	magic = e["magic"]
	hometown = e["hometown"]
	
	$nameLabel.text = enemy_name
	
	print("PICKED " + str(enemy_name).to_upper() + " THE FIERCE VILLAIN FROM " + str(hometown).to_upper())
	
	get_tree().current_scene.announceReady()
	
	print(power)
	maxHealth = remap(power, 0, 30, 0, 200)
	health = maxHealth
	print(strength)
	damageDealing = remap(strength, 0, 30, 0, 50)
