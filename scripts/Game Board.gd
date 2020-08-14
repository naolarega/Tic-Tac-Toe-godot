extends MarginContainer

enum player{ONE = 1, TWO}
var score = [0, 0]
var game_type
var icon_Set
var turn = player.ONE
var total_turns = 0
var board_grid = []
var placeholder_textures = [
	preload("res://images/place_holder.png"),
	preload("res://images/empty.png")]
var sun_moon_textures = [
	preload("res://images/sun.png"),
	preload("res://images/moon.png")]
var xo_textures = [
	preload("res://images/x.png"),
	preload("res://images/o.png")]
var player_avatar = [
	preload("res://images/human.png"),
	preload("res://images/cpu.png")]
var board_grid_textures = [
	preload("res://images/board_grid_3x3.png"),
	preload("res://images/board_grid_4x4.png"),
	preload("res://images/board_grid_5x5.png")]

func init_board():
	var singleton = $"/root/main"
	
	game_type = singleton.game_type_choice
	icon_Set = singleton.icon_set_choice
	
	set_player_type(singleton)
	add_cells(game_type)
	board_grid.resize(pow(game_type, 2))
	empty_board()	

func set_board_grid_texture():
	if game_type == 3:
		$"VBoxContainer/CenterContainer/Board grid".texture = board_grid_textures[0]
	elif game_type == 4:
		$"VBoxContainer/CenterContainer/Board grid".texture = board_grid_textures[1]
	else:
		$"VBoxContainer/CenterContainer/Board grid".texture = board_grid_textures[2]

func add_cells(grid):
	var r = grid
	var c = grid
	var cell_number = 0
	
	$"VBoxContainer/CenterContainer/Cell grid".columns = c
	set_board_grid_texture()
	
	for i in c:
		for j in r:
			var cell = TextureRect.new()
			cell.name = String(cell_number)
			cell.texture = placeholder_textures[1]
			$"VBoxContainer/CenterContainer/Cell grid".add_child(cell)
			cell.connect("gui_input", self, "_on_cell_pressed", [cell.name])
			cell_number += 1

func change_player_piece(target_node, player_piece):
	var node_to_change = "./VBoxContainer/CenterContainer/Cell grid/" + target_node
	get_node(node_to_change).texture = player_piece

func parse_cell_position(cell :String) -> int:
	var value = cell as int
	return value

func set_player_type(singleton):
	if singleton.player_type_choice == singleton.player_type.PVP:
		$"VBoxContainer/Score board/HBoxContainer/Player1/Player1 avatar".texture = player_avatar[0]
		$"VBoxContainer/Score board/HBoxContainer/Player2/Player2 avatar".texture = player_avatar[0]
	else:
		$"VBoxContainer/Score board/HBoxContainer/Player1/Player1 avatar".texture = player_avatar[0]
		$"VBoxContainer/Score board/HBoxContainer/Player2/Player2 avatar".texture = player_avatar[1]

func win() -> bool:
	var win = false
	var cell_match = 0
	for r in range(game_type):
		for i in range(game_type - 1):
			if board_grid[i + (r * game_type)] == board_grid[(i + (r * game_type)) + 1]:
				if board_grid[i + (r * game_type)] != 0 and board_grid[(i + (r * game_type)) + 1] != 0:
					cell_match += 1
					if i == game_type - 2:
						cell_match += 1
		if cell_match == game_type:
			print("Row: " + r as String)
			win = true
			break
		else:
			cell_match = 0
	if cell_match == 0:
		for c in range(game_type):
			for i in range(game_type - 1):
				if board_grid[(i * game_type) + c] == board_grid[((i * game_type) + c) + game_type]:
					if board_grid[(i * game_type) + c] != 0 and board_grid[((i * game_type) + c) + game_type] != 0:
						cell_match += 1
						if i == game_type - 2:
							cell_match += 1
			if cell_match == game_type:
				print("Column: " + c as String)
				win = true
				break
			else:
				cell_match = 0
	if cell_match == 0:
		for i in range(game_type - 1):
			if board_grid[i * (game_type + 1)] == board_grid[(i * (game_type + 1)) + game_type + 1]:
				if board_grid[i * (game_type + 1)] != 0 and board_grid[(i * (game_type + 1)) + game_type + 1] != 0:
					cell_match += 1
					if i == game_type - 2:
						cell_match += 1
		if cell_match == game_type:
			print("Diagonal 0!")
			win = true
		else:
			cell_match = 0
	if cell_match == 0:
		for i in range(1, game_type):
			if board_grid[i * (game_type - 1)] == board_grid[i * (game_type - 1) + game_type - 1]:
				if board_grid[i * (game_type - 1)] != 0 and board_grid[i * (game_type - 1) + game_type - 1] != 0:
					cell_match += 1
					if i == game_type - 1:
						cell_match += 1
		if cell_match == game_type:
			print("Diagonal 1!")
			win = true
	return win

func draw() -> bool:
	if !win() and total_turns == pow(game_type, 2) - 1:
		return true
	else:
		return false

func check_winner():
	var winner
	if win():
		if turn == player.ONE:
			winner = "Player one Won"
			score[0] += 1
			$"VBoxContainer/Score board/HBoxContainer/Player1/Player1 score".text = score[0] as String
		else:
			if $"/root/main".player_type_choice == $"/root/main".player_type.PVP:
				winner = "Player two Won"
			else:
				winner = "Computer won"
			score[1] += 1
			$"VBoxContainer/Score board/HBoxContainer/Player2/Player2 score".text = score[1] as String
		$"Game popup/Background color/MarginContainer/VBoxContainer/Winner center/Winner".text = winner
		print(winner)
		$"Game popup".visible = true
		total_turns = 0
	elif draw():
		winner = "Draw"
		$"Game popup/Background color/MarginContainer/VBoxContainer/Winner center/Winner".text = winner
		$"Game popup".visible = true
		total_turns = 0
	else:
		total_turns += 1

func empty_board():
	for i in board_grid.size():
		board_grid[i] = 0

func reset_board():
	empty_board()
	for c in $"VBoxContainer/CenterContainer/Cell grid".get_children():
		c.texture = placeholder_textures[1]

func check_turn(cell):
	if turn == player.ONE:
		turn = player.TWO
		change_player_piece(cell, sun_moon_textures[0])
	else:
		turn = player.ONE
		change_player_piece(cell, sun_moon_textures[1])

func _ready():
	init_board()
	if $"/root/Game/Background/Game Board/Pause menu/MarginContainer/VBoxContainer/Continue center/Continue".connect("pressed", self, "_on_continue_pressed") != OK:
		print("Unable to connect Continue signal!")
	if $"/root/Game/Background/Game Board/Pause menu/MarginContainer/VBoxContainer/Exit center/Exit".connect("pressed", self, "_on_exit_pressed") != OK:
		print("Unable to connect Exit signal! ")

func _on_cell_pressed(event, cell):
	var current_cell = parse_cell_position(cell)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			board_grid[current_cell] = turn
			check_winner()
			check_turn(cell)
			

func _on_Pause_button_pressed():
	visible = false
	$"../Pause menu".visible = true
	get_tree().paused = true

func _on_continue_pressed():
	$"../Pause menu".visible = false
	visible = true
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().paused = false
	$"/root/main".goto_scene("res://scenes/ui/Main menu.tscn")

func _on_Retry_pressed():
	reset_board()
	turn = player.ONE
	$"Game popup".visible = false

func _on_New_game_pressed():
	reset_board()
	turn = player.ONE
	score[0] = 0
	score[1] = 0
	$"VBoxContainer/Score board/HBoxContainer/Player1/Player1 score".text = 0 as String
	$"VBoxContainer/Score board/HBoxContainer/Player2/Player2 score".text = 0 as String
	$"Game popup".visible = false
	
