extends ColorRect

@onready var filter_path = $Filter
var slot_ID := -1
signal slot_clicked(slot)
var land_type: String
var state = DataHandler.slot_states.NONE
var piece_color = self.color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_tile(c) -> void:
	color = c

func set_state(color = DataHandler.slot_states.NONE):
	state=color
	match color:
		DataHandler.slot_states.NONE:
			filter_path.color = Color(0,0,0,0)
		DataHandler.slot_states.FREE:
			filter_path.color = Color(0,1,0,0.5)
	pass

func set_land_type_water():
	land_type = "water"


func _on_filter_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		emit_signal("slot_clicked", self)
