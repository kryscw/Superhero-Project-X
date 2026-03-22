extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Player")
var speed = 200.0
var maxHealth = 100
var health = maxHealth
var baseDamage = 0
var damage = baseDamage
var damageDealing = 25
var enemy_name
var power
var strength
var magic
var hometown
@onready var main = get_tree().current_scene
enum STATE_MACHINE {
	ATTACK,
	RUN,
	SHIELD
}
var attacks = ["AOE", "BULLET"]
var bullet = preload("res://Scenes/bulletEvil.tscn")

var bulletSpeed = 250

var currentState = STATE_MACHINE.RUN

var soundfont_em = ["hit_em", "hit_em2", "hit_em3", "hit_em4", "hit_em5"]
var soundfont_sumit = ["enemy_hitsumit", "enemy_hitsumit2", "enemy_hitsumit3"]
var soundfonts = [soundfont_em, soundfont_sumit]

var soundfont = soundfonts[randi_range(0, soundfonts.size()-1)]

## And zat is how I lost my game development license... - Medic TF2

func _process(_delta: float) -> void:
	if player == null: return
	$healthBar.value = remap(health, 0, maxHealth, 0.0, 100)
	if main.gameStarted:
		if currentState == STATE_MACHINE.SHIELD: damage = 0; $AnimatedSprite2D.modulate = "000000"
		else: damage = baseDamage; $AnimatedSprite2D.modulate = "FFFFFF"
		if currentState == STATE_MACHINE.RUN:
			speed = 400.0
			$AnimatedSprite2D.play("walk")
			velocity = (player.global_position - global_position).normalized() * speed
			if velocity.x > 0: $AnimatedSprite2D.flip_h = true
			elif velocity.x < 0: $AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("idle")
			velocity.x = 0
	velocity.y += 800
	move_and_slide()
	if health <= 0:
		queue_free()
		print("YOU WIN!")
		main.win()

func _on_damage_area_hit(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is CharacterBody2D && body != player && body != self:
		body.queue_free()
		main.cam.add_trauma(0.15)
		health -= damage
		$Hit.pitch_scale = randf_range(0.95, 1.05)
		if !currentState == STATE_MACHINE.SHIELD:
			$Hit.stream = load("res://Audio/" + soundfont[randi_range(0, soundfont.size()-1)] + ".ogg")
			$Hit.play()
		else:
			$Hit.stream = load("res://Audio/enemy_block.ogg")
			$Hit.play()

var enemies = superIndex.villains
var shuffled_enemies = []
var enemy_index = 0

func makeBullet():
	print("BULLETE")
	var x = bullet.instantiate()
	x.global_position = self.global_position
	x.direction = (player.global_position - global_position).normalized() * bulletSpeed
	get_tree().current_scene.add_child(x)
	
func attack():
	if player == null: return
	var dist = player.global_position - global_position
	
	if dist.x < 40:
		for i in 3:
			makeBullet()
			await get_tree().create_timer(0.25).timeout
	else:
		$GPUParticles2D.emitting = true
		for i in $areaOfEffect.get_overlapping_bodies():
			if i.name.match("Player"):
				i.damage(10)

func _on_state_timer_timeout() -> void:
	$stateTimer.wait_time = randf_range(1, 3)
	currentState = STATE_MACHINE.values()[randi_range(0, STATE_MACHINE.size()-1)]
	if currentState == STATE_MACHINE.ATTACK: attack()

func begin():
	$stateTimer.start()
	$stateTimer.wait_time = randf_range(1, 3)
	baseDamage = player.damageDealing
	damage = baseDamage

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
	maxHealth = remap(power, 0, 30, 300, 600)
	health = maxHealth
	print(strength)
	damageDealing = remap(strength, 0, 30, 5, 20)
