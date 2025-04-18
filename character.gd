class_name Character

extends Node2D

@export var character_name: String = ""
@export var round_dialogue: DialogueResource

func _ready():
	round_dialogue = load("res://dialogue/round1.dialogue")
	$Button.pressed.connect(_on_button_pressed)
	$Button.text = character_name

func _on_button_pressed():
	DialogueManager.show_dialogue_balloon(round_dialogue, character_name.to_lower())
