extends Node

var assets := []
enum PieceNames {TANK, PLANE}

enum slot_states {NONE, FREE}

# Called when the node enters the scene tree for the first time.
func _ready():
	assets.append("res://assets/Tank.png")
	assets.append("res://assets/Plane.png") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
