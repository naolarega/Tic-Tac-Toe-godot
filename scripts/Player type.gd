extends Control


func goto_game(player_type):
	main.player_type_choice = player_type
	main.goto_scene("res://scenes/Game.tscn", 0.0)

func _on_PvP_pressed():
	goto_game(main.player_type.PVP)

func _on_PvC_pressed():
	goto_game(main.player_type.PVC)
