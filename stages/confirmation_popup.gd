class_name ConfirmationPopup

extends Control

signal yes_pressed
signal no_pressed


func _on_yes_button_pressed() -> void:
	yes_pressed.emit()


func _on_no_button_pressed() -> void:
	no_pressed.emit()
