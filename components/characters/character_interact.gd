class_name Character

extends Control

@export var character_name: String = ""
@export var round_dialogue: DialogueResource
@onready var button: Button = $Button

func _ready():
	round_dialogue = load("res://dialogue/round1.dialogue")
	button.pressed.connect(_on_button_pressed)
	button.text = character_name
	button.add_theme_font_size_override("font_size", 48)

func _on_button_pressed():
	DialogueManager.show_dialogue_balloon(round_dialogue, character_name.to_lower())
