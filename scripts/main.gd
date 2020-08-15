# autoload manager script
extends Node

enum player_type{PVP, PVC}
enum game_type{THREE = 3, FOUR, FIVE}
enum icon_set{XO, SUN_MOON}

var player_type_choice = player_type.PVP
var game_type_choice = game_type.THREE
var icon_set_choice = icon_set.XO
var preference

func goto_scene(scene :String, load_delay: float):
	if get_tree().change_scene("res://scenes/ui/Loading screen.tscn") != OK:
		print("Error loading Loading screen scene!")
	yield(get_tree().create_timer(load_delay), "timeout") 
	get_tree().current_scene.queue_free()
	if get_tree().change_scene(scene) != OK:
		print("Error loading Requested scene!")

func save_preference():
	var json
	preference = {
		"game_type" : game_type_choice,
		"icon_set" : icon_set_choice
	}
	var file = File.new()
	file.open("res://savegame.ttt", File.WRITE)
	json = to_json(preference)
	file.store_line(json)

func load_preference():
	var json
	var file = File.new()
	
	if !file.file_exists("res://savegame.ttt"):
		return
		
	file.open("res://savegame.ttt", File.READ)
	json = file.get_line()
	preference = parse_json(json)
	game_type_choice = preference["game_type"]
	icon_set_choice = preference["icon_set"]

func _ready():
	load_preference()

func _notification(what):
	if what == NOTIFICATION_EXIT_TREE or what == NOTIFICATION_WM_QUIT_REQUEST:
		save_preference()
		print("Bye")
