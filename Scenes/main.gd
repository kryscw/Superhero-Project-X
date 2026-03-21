extends Node2D

func announceReady():
	$CanvasLayer/enemyLabel.text = "NOW FACING " + $Enemy.enemy_name.to_upper()
	
	$CanvasLayer/underEnemyLabel.text = "THE FIERCE VILLAIN FROM " + $Enemy.hometown.to_upper()
