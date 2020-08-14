extends Control

func _ready():
	pass

func _on_Exit_pressed():
	get_tree().quit()

func _on_Setting_pressed():
	$Settings.visible = true
	$"Background color/Main menu margin".visible = false

func _on_Close_settings_pressed():
	$Settings.visible = false
	$"Background color/Main menu margin".visible = true

func _on_Play_pressed():
	$"/root/main".goto_scene("res://scenes/game/Player type.tscn")

func _on_3by3_gui_input(event):
	pass # Replace with function body.

func _on_4by4_gui_input(event):
	pass # Replace with function body.

func _on_5by5_gui_input(event):
	pass # Replace with function body.

func _on_XO_gui_input(event):
	pass # Replace with function body.

func _on_Sun_moon_gui_input(event):
	pass # Replace with function body.
