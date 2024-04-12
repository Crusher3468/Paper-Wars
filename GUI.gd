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
			if j%2 == colorbit:
				grid_array[i*10+j].set_tile(Color.AQUA)
		if colorbit==0:
			colorbit=1
		else: colorbit=0
	
	piece_array.resize(64)
	piece_array.fill(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	board_grid.add_child(new_slot)
	grid_array.push_back(new_slot)

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
		pass


func _on_test_btn_pressed():
	add_piece(DataHandler.PieceNames.PLANE, 10)# Replace with function body.
