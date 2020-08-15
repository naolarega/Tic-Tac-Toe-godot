extends Control

var game_type_choice = {
	"3by3" : [
		preload("res://images/3by3.png"),
		preload("res://images/3by3_selection.png")],
	"4by4" : [
		preload("res://images/4by4.png"),
		preload("res://images/4by4_selection.png")],
	"5by5" : [
		preload("res://images/5by5.png"),
		preload("res://images/5by5_selection.png")]}
var icon_set_choice = {
	"xo" : [
		preload("res://images/iconset_xo.png"),
		preload("res://images/iconset_xo-selection.png")],
	"sun_moon" : [
		preload("res://images/iconset_sun_moon.png"),
		preload("res://images/iconset_sun_moon_selection.png")]}

func set_setting_look(type, icons):
	if type == main.game_type.THREE:
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/3by3".texture = game_type_choice["3by3"][1]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/4by4".texture = game_type_choice["4by4"][0]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/5by5".texture = game_type_choice["5by5"][0]
	elif type == main.game_type.FOUR:
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/3by3".texture = game_type_choice["3by3"][0]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/4by4".texture = game_type_choice["4by4"][1]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/5by5".texture = game_type_choice["5by5"][0]
	elif type == main.game_type.FIVE:
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/3by3".texture = game_type_choice["3by3"][0]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/4by4".texture = game_type_choice["4by4"][0]
		$"Settings/MarginContainer/VBoxContainer/Difficulty container/5by5".texture = game_type_choice["5by5"][1]
		
	if icons == main.icon_set.XO:
		$"Settings/MarginContainer/VBoxContainer/Iconsets container/XO".texture = icon_set_choice["xo"][1]
		$"Settings/MarginContainer/VBoxContainer/Iconsets container/Sun moon".texture = icon_set_choice["sun_moon"][0]
	elif icons == main.icon_set.SUN_MOON:
		$"Settings/MarginContainer/VBoxContainer/Iconsets container/XO".texture = icon_set_choice["xo"][0]
		$"Settings/MarginContainer/VBoxContainer/Iconsets container/Sun moon".texture = icon_set_choice["sun_moon"][1]

func left_mouse_button(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		return true
	return false

func _ready():
	set_setting_look(main.game_type_choice, main.icon_set_choice)

func _on_Exit_pressed():
	get_tree().quit()

func _on_Setting_pressed():
	$Settings.visible = true
	$"Background color/Main menu margin".visible = false

func _on_Close_settings_pressed():
	$Settings.visible = false
	$"Background color/Main menu margin".visible = true

func _on_Play_pressed():
	$"/root/main".goto_scene("res://scenes/game/Player type.tscn", 1.0)

func _on_3by3_gui_input(event):
	if left_mouse_button(event):
		main.game_type_choice = main.game_type.THREE
		set_setting_look(main.game_type_choice, main.icon_set_choice)

func _on_4by4_gui_input(event):
	if left_mouse_button(event):
		main.game_type_choice = main.game_type.FOUR
		set_setting_look(main.game_type_choice, main.icon_set_choice)

func _on_5by5_gui_input(event):
	if left_mouse_button(event):
		main.game_type_choice = main.game_type.FIVE
		set_setting_look(main.game_type_choice, main.icon_set_choice)

func _on_XO_gui_input(event):
	if left_mouse_button(event):
		main.icon_set_choice = main.icon_set.XO
		set_setting_look(main.game_type_choice, main.icon_set_choice)

func _on_Sun_moon_gui_input(event):
	if left_mouse_button(event):
		main.icon_set_choice = main.icon_set.SUN_MOON
		set_setting_look(main.game_type_choice, main.icon_set_choice)
