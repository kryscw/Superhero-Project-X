extends Button

@export var label: Label

@export var action_name : String = "left"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"left":
			label.text = "Left"
		"right":
			label.text = "Right"
		"jump":
			label.text = "Jump"
		"shoot":
			label.text = "Shoot"
		"dash":
			label.text = "Dash"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	
	if action_events.size() > 0:
		var action_event = action_events[0]
		if action_event is InputEventKey:
			var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
			text = "%s" % action_keycode
		elif action_event is InputEventMouseButton:
			text = "Mouse Button %d" % action_event.button_index
		else:
			text = "Unsupported Input"
	else:
		text = "No Input Event"

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "Listening"
		set_process_unhandled_key_input(toggled_on)
		
	#	for i in get_tree().get_nodes_in_group("hotkey_button"):
	#		if i.action_name != self.action_name:
	#			i.toggle_mode = false
		#		i.set_process_unhandled_key_input(false)
	else:
		#for i in get_tree().get_nodes_in_group("hotkey_button"):
		#	if i.action_name != self.action_name:
		#		i.toggle_mode = false
		#		i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button_pressed = false
	
func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
