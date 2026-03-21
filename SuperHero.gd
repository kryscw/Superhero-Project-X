extends Node2D

var heroes = []

func _ready():
	load_heroes_from_csv()
	print("Heroes loaded:", heroes.size())

	# TEST (remove later if needed)
	print(heroes)

func load_heroes_from_csv():
	var file = FileAccess.open("res://HackBeta - Superhero CSV.csv", FileAccess.READ)

	if file == null:
		print("File not found!")
		return

	# skip header
	file.get_line()

	while not file.eof_reached():
		var line = file.get_line().strip_edges()

		if line == "":
			continue

		var data = line.split(",")

		if data.size() < 4:
			continue

		var hero = {
			"name": data[0].strip_edges(),
			"power": int(data[1]),
			"strength": int(data[2]),
			"magic": int(data[3])
		}

		heroes.append(hero)
