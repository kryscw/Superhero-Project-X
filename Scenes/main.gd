extends Node2D

var gameStarted = false

@onready var cam = $Camera2D

func _ready():
	$CanvasLayer/AnimationPlayer.play("FadeIn")
	await $CanvasLayer/AnimationPlayer.animation_finished
	gameStarted = true

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
