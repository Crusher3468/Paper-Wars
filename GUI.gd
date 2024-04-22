extends Control

@onready var slot_scene = preload("res://slot.tscn")
@onready var board_grid = $Board/BoardGrid
@onready var piece_scene = preload("res://Piece.tscn")
@onready var board = $Board

var grid_array := []
var piece_array := []
var icon_offset := Vector2(32, 32)

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
		if colorbit==0:
			colorbit=1
		else: colorbit=0
	
	piece_array.resize(100)
	piece_array.fill(0)

func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	board_grid.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_clicked.connect(_on_slot_clicked)

func _on_slot_clicked(slot):
	if not piece_selected:
		return
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

func add_piece(piece_type, location):
	var new_piece = piece_scene.instantiate()
	board.add_child(new_piece)
	new_piece.type = piece_type
	new_piece.load_icon(piece_type)
	new_piece.global_position = grid_array[location].global_position + icon_offset
	piece_array[location] = new_piece
	new_piece.slot_ID = location
	new_piece.piece_selected.connect(_on_piece_selected)

func _on_piece_selected(piece):
	if not piece_selected:
		piece_selected = piece
	else:
		_on_slot_clicked(grid_array[piece.slot_ID])

func set_board_filter(bitmap:int):
	for i in range(100):
		if bitmap & 1:
			grid_array[99-i].set_state(DataHandler.slot_states.FREE)
		bitmap = bitmap >> 1

func _on_test_btn_pressed():
	add_piece(DataHandler.PieceNames.PLANE, 10)
	add_piece(DataHandler.PieceNames.PLANE, 19)

