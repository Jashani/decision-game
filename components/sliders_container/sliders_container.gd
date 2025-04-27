extends Control


var MINIMUM_LABEL_WIDTH = 0


@export var data: SlidersContainerData = null
var text_labels: PackedStringArray = []
var labels: HBoxContainer = null
var sliders: VBoxContainer = null
var slider_with_name_scene: PackedScene = load("res://components/sliders_container/slider_with_name.tscn")


func _ready():	
	labels = find_child("Labels")
	sliders = find_child("Sliders")

	for label in data.labels:
		_create_label(label)

	for character in data.characters:
		_create_slider(character)


func _create_label(text: String):
	var label = Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("font_size", 24)
	labels.add_child(label)


func _create_slider(character_data: CharacterData):
	var slider: SliderWithName = slider_with_name_scene.instantiate()
	slider.label = character_data.name
	slider.icon = character_data.icon
	sliders.add_child(slider)


#
#func _draw_text_labels():
	#var positions = _equally_distanced_positions_across_bar(text_labels.size(), true)
	#for i in range(positions.size()):
		#var arbitrary_width = 300
		#var arbitrary_push_down = 100
		#var pos = _value_to_position(positions[i])
		#pos.y = pos.y + arbitrary_push_down
		#pos.x = pos.x - arbitrary_width / 2.0
		#draw_string(font, pos, text_labels[i], HORIZONTAL_ALIGNMENT_CENTER, arbitrary_width)
#
#
#func _equally_distanced_positions_across_bar(count, include_edges=false):
	#if include_edges:
		#count = count - 2
	#
	#var _range = MAX_VALUE - MIN_VALUE
	#var jump = _range / (count + 1)
	#var positions = []
	#for i in range(count):
		#positions.append((i + 1 ) * jump)
	#
	#if include_edges:
		#positions.insert(0, MIN_VALUE)
		#positions.append(MAX_VALUE)
	#
	#return positions
