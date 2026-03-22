extends Node2D

var gameStarted = false

@onready var cam = $Camera2D

func _ready():
	$CanvasLayer/AnimationPlayer.play("FadeIn")
	await $CanvasLayer/AnimationPlayer.animation_finished
	gameStarted = true
	$Enemy.begin()

func announceReady():
	
	var strengthRating = "";
	var powerRating = "";
	
	if $Enemy.strength > 70: strengthRating = "DANGEROUS"
	elif $Enemy.strength > 40: strengthRating = "AVERAGE"
	else: strengthRating = "WEAKLING"
		
	if $Enemy.power > 70: powerRating = "BEEFY"
	elif $Enemy.power > 40: powerRating = "NORMAL"
	else: powerRating = "WEAKLING"
	
	$CanvasLayer/labels/enemyLabel.text = "NOW FACING: " + $Enemy.enemy_name.to_upper()
	
	$CanvasLayer/labels/underEnemyLabel.text = "FROM " + $Enemy.hometown.to_upper()

	$CanvasLayer/labels/stats.text = "POWER: " + powerRating + " (" + str($Enemy.power) + ")" + "\nSTRENGTH: " + strengthRating + " (" + str($Enemy.strength) + ")"

func win():
	$Die.play()
	print("yo it's the main script here... you WON!?!?!?!?!?")
	$CanvasLayer/ThreeChoices.show()

func restartGame():
	$CanvasLayer/ThreeChoices.hide()
	gameStarted = false
	var x = load("res://Scenes/Enemy.tscn").instantiate()
	$CanvasLayer/newVillain.pitch_scale += 0.05
	$Player.health = 100
	x.global_position = Vector2(15, 15)
	add_child(x)
	$CanvasLayer/AnimationPlayer.play("FadeIn")
	await $CanvasLayer/AnimationPlayer.animation_finished
	gameStarted = true
	$Enemy.begin()

func _on_fire_rate_upgrade_pressed() -> void:
	$Player/weaponRot/countdownTimer.wait_time -= 0.025
	restartGame()
	


func _on_speed_upgrade_pressed() -> void:
	$Player.currentSpeed += 50
	restartGame()
	


func _on_damage_upgrade_pressed() -> void:
	$Player.damageDealing += 5
	restartGame()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Menu.tscn")
