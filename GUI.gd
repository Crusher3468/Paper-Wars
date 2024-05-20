extends Control

@onready var slot_scene = preload("res://slot.tscn")
@onready var board_grid = $Board/BoardGrid
@onready var piece_scene = preload("res://Piece.tscn")
@onready var board = $Board
@onready var turn_tracker = $TurnTracker
@onready var actions_tracker = $Actions
@onready var bitboard = $BitBoard

var grid_array := []
var piece_array := []
var icon_offset := Vector2(32, 32)
var fen = "bbbbbpppttt/10/10/10/10/10/10/10/10/bbbbbpppttt"
var player1 = true
var actions = 3

var piece_selected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(100):
		create_slot()
		
	var colorbit =0
	for i in range(10):
		for j in range(10):
			if j<5:
				grid_array[i*10+j].set_tile(Color.AQUA)
				grid_array[i*10+j].set_land_type_water()
		if colorbit==0:
			colorbit=1
		else: colorbit=0
	
	piece_array.resize(100)
	piece_array.fill(0)
	
	turn_tracker.text = "Player 1's Turn"
	actions_tracker.text = str(actions)

func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	new_slot.land_type = "land"
	board_grid.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_clicked.connect(_on_slot_clicked)

func _on_slot_clicked(slot):
	if not piece_selected:
		return
	var piece_enum = piece_selected.type
	if piece_enum == DataHandler.PieceNames.TANK && slot.land_type == "land" :
		move_piece(piece_selected, slot.slot_ID)
	if piece_enum == DataHandler.PieceNames.BOAT && slot.land_type == "water" :
		move_piece(piece_selected, slot.slot_ID)
	if piece_enum == DataHandler.PieceNames.PLANE :
		move_piece(piece_selected, slot.slot_ID)
	piece_selected = null
	
func move_piece(piece, location):
	if (piece_array[location]):
		piece_array[location].queue_free()
		piece_array[location] = 0
		
	var tween = get_tree().create_tween()
	tween.tween_property(piece, "global_position", grid_array[location].global_position +icon_offset, 0.2)
	piece_array[piece.slot_ID] = 0
	piece_array[location]= piece
	piece.slot_ID = location
	use_action()

func add_piece(piece_type, location):
	var new_piece = piece_scene.instantiate()
	board.add_child(new_piece)
	new_piece.type = piece_type
	new_piece.load_icon(piece_type)
	new_piece.global_position = grid_array[location].global_position + icon_offset
	piece_array[location] = new_piece
	new_piece.slot_ID = location
	new_piece.piece_selected.connect(_on_piece_selected)

func parse_fen(fen : String)->void:
	var boardstate = fen.split(" ")
	var board_indew := 0

func _on_piece_selected(piece):
	if not piece_selected:
		piece_selected = piece
	else:
		_on_slot_clicked(grid_array[piece.slot_ID])

func set_board_filter(bitmap:int):
	for i in range(100):
		if bitmap & 1:
			grid_array[i].set_state(DataHandler.slot_states.FREE)
		bitmap = bitmap >> 1

func _on_test_btn_pressed():
	set_board_filter(1023)
	bitboard.call("TestFunc")
	add_piece(DataHandler.PieceNames.BOAT, 10)
	add_piece(DataHandler.PieceNames.TANK, 19)
	add_piece(DataHandler.PieceNames.PLANE, 25)

func update_UI():
	if (player1):
		turn_tracker.text = "Player 1's Turn"
		actions_tracker.text = str(actions)
	else:
		turn_tracker.text = "Player 2's Turn"
		actions_tracker.text = str(actions)
		
func use_action():
	actions = actions - 1
	actions_tracker.text = str(actions)
	if (actions <= 0 && player1):
		player1 = false
		actions = 3
		update_UI()
	else : if (actions <= 0 && !player1):
		player1 = true
		actions = 3
		update_UI()
