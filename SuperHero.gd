extends Node2D

## REF superIndex

var heroes = []
var villains = []

func _ready():
	var file = FileAccess.open("res://HackBeta - Superhero CSV.csv", FileAccess.READ)

	if file == null:
		print("File not found!")
		return

	file.get_line() # skip header

	while not file.eof_reached():
		var line = file.get_line()

		if line == null:
			continue

		line = line.strip_edges()

		if line == "":
			continue

		var data = line.split(",")

		if data.size() < 2:
			continue

		# 👇 GET LAST COLUMN (THIS FIXES EVERYTHING)
		var is_villain_raw = data[data.size() - 1].strip_edges().to_lower()

		var is_villain = (is_villain_raw == "true")

		var character = {
			"name": data[0].strip_edges(),
			"power": int(data[1]),
			"strength": int(data[2]),
			"magic": int(data[3])
		}

		if is_villain:
			villains.append(character)
		else:
			heroes.append(character)

	print("Heroes:", heroes.size())
	print("Villains:", villains.size())
