extends Node2D

var heroes = []
var villains = []

func _ready():
	load_heroes_from_csv()
	await get_tree().create_timer(1).timeout
	print("HERO: " + str(heroes[0]))
	print("VILLAIN: " + str(villains[0]))

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
			"magic": int(data[3]),
			"isvillain": data[18]
		}
	
		if hero["isvillain"] == " False":
			heroes.append(hero)
		else:
			villains.append(hero)
