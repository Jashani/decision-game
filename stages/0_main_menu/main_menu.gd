extends Control

func _ready() -> void:
	_enable_keyboard_control()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/1_round_start/round_start.tscn")


func _on_options_button_pressed() -> void:
	push_error("Options not implemented.")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _enable_keyboard_control() -> void:
	$VBoxContainer/StartButton.grab_focus()
