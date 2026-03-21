extends Control



func _ready():
	pass

func _on_StartGame_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_Options_pressed():
	pass

func _on_Exit_pressed():
	get_tree().quit()
