extends Control


func goto_game(player_type):
	$"/root/main".player_type_choice = player_type
	$"/root/main".goto_scene("res://scenes/Game.tscn")

func _on_PvP_pressed():
	goto_game($"/root/main".player_type.PVP)

func _on_PvC_pressed():
	goto_game($"/root/main".player_type.PVC)
