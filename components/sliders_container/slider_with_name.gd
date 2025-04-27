class_name SliderWithName

extends HBoxContainer

const MAX_SIZE = 250

# The label displayed to the left. Avoid making it too long
@export var label: String = ""
@export var icon: Texture = null


func _ready() -> void:
	$Name.text = label
	
	if size.x > MAX_SIZE:
		push_error("Label is too long in slider with name: " + label)
