class_name SliderWithName

extends GridContainer

const MAX_NAME_SIZE = 250

# The label displayed to the left. Avoid making it too long
@export var _name: String = ""
# An icon for the slider grabber
@export var icon: Texture2D = null
# Labels to display under slider
@export var labels: PackedStringArray = []
# Toggle labels row under slider
@export var hide_labels: bool = true

@onready var name_label: Label = $Name
@onready var labels_container: HBoxContainer = $Labels
@onready var padding: Control = $Padding

func _ready() -> void:
	name_label.text = _name
	
	if name_label.size.x > MAX_NAME_SIZE:
		push_error("Label is too long in slider with name: " + _name)
	
	if hide_labels:
		_hide_labels()
	else:
		_create_labels()


func _create_labels() -> void:
	for index in range(labels.size()):
		var label = Label.new()
		label.text = labels[index]
		label.add_theme_font_size_override("font_size", 24)
		labels_container.add_child(label)
		# if not last item
		if index < labels.size() - 1:
			labels_container.add_spacer(false)


func _hide_labels() -> void:
	padding.hide()
	labels_container.hide()
