extends TextureRect

var value = 0.0
var index = -1
var parent_bar = null

func _ready():
	if not parent_bar:
		push_error("Parent bar is not set on icon when icon entered scene tree!")

	gui_input.connect(_on_gui_input)

func _on_gui_input(event):
	# Forward input events to parent bar
	parent_bar._on_icon_gui_input(event, self)

# Set the current value and update position if parent bar is available
func set_value(new_value):
	value = new_value
	parent_bar._update_icon_position_from_value(self)

# Gets called by parent bar when moved
func update_position(new_position):
	position = new_position

# Visual feedback when dragging begins
func start_drag():
	z_index = 1
	modulate.a = 0.7

# Visual feedback when dragging ends
func end_drag():
	z_index = 0
	modulate.a = 1.0
