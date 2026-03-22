extends Node2D

var gameStarted = true

func announceReady():
	$CanvasLayer/labels/enemyLabel.text = "NOW FACING " + $Enemy.enemy_name.to_upper()
	
	$CanvasLayer/labels/underEnemyLabel.text = "THE FIERCE VILLAIN FROM " + $Enemy.hometown.to_upper()

	$CanvasLayer/labels/stats.text = "POWER: " + str($Enemy.power) + " STRENGTH: " + str($Enemy.strength)

func win():
	$Die.play()
	print("yo it's the main script here... you WON!?!?!?!?!?")
