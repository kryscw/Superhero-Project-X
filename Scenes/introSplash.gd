extends Node2D

func _ready():
	$AnimationPlayer.play("intro")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Main_Menu.tscn")
