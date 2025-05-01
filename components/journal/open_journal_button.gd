class_name OpenJournalButton

extends Control


@export var journal: Journal = null


func _ready() -> void:
	journal.hide()


func _on_button_pressed() -> void:
	journal.show()
