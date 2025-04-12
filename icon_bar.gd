extends Control

# Bar configuration
@export var icon_size: int = 64
@export var value_label_steps: int = 10  # Display labels at increments of this value (0, 10, 20...)
@export var draggable_icon_scene: PackedScene
@export var icon_count: int = 4
@export var labels: Array[String] = ["Left", "Middle", "Right"]

@onready var bar_rect: PanelContainer = $BarRect  # This should be a PanelContainer child node

const MAX_VALUE = 100.0
const MIN_VALUE = 0.0

var icons = []
var dragging = false
var dragged_icon = null

# Value bar area tracking
var usable_width = 0
var bar_x_start = 0
var bar_x_end = 0

signal icon_value_changed(icon_index, new_value)

func _ready():
	if not bar_rect:
		push_error("BarRect node not found! Add a PanelContainer as a child node named 'BarRect'")
		return
	
	if not draggable_icon_scene:
		push_error("You must assign a DraggableIcon scene to the ValueBar!")
		return

	_set_bar_constraints()
	_place_icons()

func _set_bar_constraints():
	var padding = icon_size / 2.0  # Use half icon size as padding
	usable_width = bar_rect.size.x - (padding * 2)
	bar_x_start = bar_rect.position.x + padding
	bar_x_end = bar_rect.position.x + bar_rect.size.x - padding

func _place_icons():
	var _range = MAX_VALUE - MIN_VALUE
	var jump = _range / (icon_count + 1)
	for i in range(icon_count):
		add_icon_at_value((i + 1) * jump)

func add_icon_at_value(value):
	if not draggable_icon_scene:
		push_error("DraggableIcon scene not set!")
		return null
	
	var icon_scene = draggable_icon_scene.instantiate()
	var icon = icon_scene.find_child("TextureRect")
	
	icon.value = value
	icon.index = icons.size()
	icon.parent_bar = self
	icon.custom_minimum_size = Vector2(icon_size, icon_size)
	icon.size = Vector2(icon_size, icon_size)
	
	_update_icon_position_from_value(icon)
	
	add_child(icon_scene)
	icons.append(icon)

# Idk why icon_size works in the x here ¯\_(ツ)_/¯
func _centered_icon_position(pos):
	return pos - Vector2(icon_size, icon_size / 2.0)

func _update_icon_position_from_value(icon):
	var pos = _value_to_position(icon.value, true)
	var centered_pos = _centered_icon_position(pos)
	icon.position = centered_pos

# Convert a value (MIN_VALUE-MAX_VALUE) to a position on the bar
func _value_to_position(value, center_vertically=false):
	value = clamp(value, MIN_VALUE, MAX_VALUE)
	
	var x = bar_x_start + (value / 100.0) * usable_width
	var y = bar_rect.position.y 
	if center_vertically:
		y = y - (bar_rect.size.y / 2)  # Center vertically by adding half of bar height
	
	return Vector2(x, y)

# Convert a position on the bar to a value (MIN_VALUE-MAX_VALUE)
func _position_to_value(pos):
	# Get the local x position relative to the bar
	var local_x = pos.x
	
	# Calculate as percentage of usable width
	var normalized_x = (local_x - bar_x_start) / float(usable_width)
	var value = normalized_x * 100.0
	return clamp(value, MIN_VALUE, MAX_VALUE)

func _start_dragging_icon(icon):
	dragging = true
	dragged_icon = icon
	icon.start_drag()

func _stop_dragging_icon():
	if not dragged_icon:
		return

	dragging = false
	dragged_icon.end_drag()
	emit_signal("icon_value_changed", dragged_icon.index, dragged_icon.value)
	dragged_icon = null

# Handle input from icons
func _on_icon_gui_input(event, icon):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		return

	if event.pressed:
		_start_dragging_icon(icon)
	else:
		_stop_dragging_icon()

func _drag_icon():
	var mouse_pos = get_viewport().get_mouse_position()
	var local_mouse_pos = mouse_pos - global_position
	
	# Constrain to horizontal movement within the bar
	var new_x = clamp(local_mouse_pos.x, bar_x_start, bar_x_end)
	var bar_height = bar_rect.position.y - (bar_rect.size.y / 2)
	var new_pos = Vector2(new_x, bar_height)
	var centered_pos = _centered_icon_position(new_pos)
	dragged_icon.position = centered_pos
	
	dragged_icon.value = _position_to_value(new_pos)

func _process(_delta):
	if dragging and dragged_icon:
		_drag_icon()	
		queue_redraw()  # Redraw to update value indicators

func _draw_ruler_tick_mark(pos):
	draw_line(
		Vector2(pos.x, pos.y), 
		Vector2(pos.x, pos.y + bar_rect.size.y), 
		Color.WHITE, 
		1
	) 

func _draw_ruler_value_text(value, pos):
	var font = get_theme_default_font()
	var under_the_bar = pos.y + bar_rect.size.y + icon_size / 2.0
	draw_string(font, Vector2(pos.x - 10, under_the_bar), str(value), HORIZONTAL_ALIGNMENT_CENTER)

func _draw_ruler():
	for i in range(0, 101, value_label_steps):
		var label_pos = _value_to_position(i)
		_draw_ruler_tick_mark(label_pos)
		_draw_ruler_value_text(i, label_pos)
		
func _draw_value_over_icon():
	var value_pos = _value_to_position(dragged_icon.value, true)
	var font = get_theme_default_font()
	draw_string(font, Vector2(value_pos.x - icon_size / 2.0, value_pos.y - 20.0), 
			   "Value: " + str(round(dragged_icon.value)), HORIZONTAL_ALIGNMENT_CENTER)

func _draw():
	_draw_ruler()
	if dragging and dragged_icon:
		_draw_value_over_icon()
