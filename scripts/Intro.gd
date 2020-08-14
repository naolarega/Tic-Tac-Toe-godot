extends Control

func open_main_menu():
	if get_tree().change_scene("res://scenes/ui/Main menu.tscn") != OK:
		print("Unable to load scene!")

func _ready():
	$AnimationPlayer.play("Fade in out")
