extends Node2D

func _ready():
	var file = FileAccess.open("res://HackBeta - Superhero CSV.csv", FileAccess.READ)

	if file == null:
		print("File not found!")
		return

	var heroes = []

	# skip header
	var header = file.get_line()

	while not file.eof_reached():
		var line = file.get_line().strip_edges()

		# skip empty lines
		if line == "":
			continue

		var data = line.split(",")

		# safety check (VERY IMPORTANT)
		if data.size() < 4:
			continue

		var hero = {
			"name": data[0].strip_edges(),
			"power": int(data[1].strip_edges()),
			"strength": int(data[2].strip_edges()),
			"magic": int(data[3].strip_edges())
		}

		heroes.append(hero)

	print("Total heroes loaded:", heroes.size())
	print(heroes)
