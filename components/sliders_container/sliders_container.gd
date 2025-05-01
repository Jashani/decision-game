class_name SlidersContainer

extends Control


var MINIMUM_LABEL_WIDTH = 0


@export var data: SlidersContainerData = null
@onready var labels: HBoxContainer = find_child("Labels")
@onready var sliders: VBoxContainer = find_child("Sliders")
@onready var title_label: Label = find_child("Title")
var slider_with_name_scene: PackedScene = load("res://components/sliders_container/slider_with_name.tscn")


func _ready():
	title_label.text = data.title
	for label in data.labels:
		_create_label(label)

	_create_sliders(data.characters)


func _create_label(text: String):
	var label = Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("font_size", 24)
	labels.add_child(label)


func _create_sliders(characters: Array[CharacterData]):
	for index in range(characters.size()):
		var with_labels: bool = false
		# if last slider
		if index == characters.size() - 1:
			with_labels = true

		_create_slider(characters[index], with_labels)



func _create_slider(character_data: CharacterData, with_labels: bool):
	var slider: SliderWithName = slider_with_name_scene.instantiate()
	slider._name = character_data.name
	slider.icon = character_data.icon
	
	if with_labels:
		slider.hide_labels = false
		slider.labels = data.labels
	
	sliders.add_child(slider)

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
