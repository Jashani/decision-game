extends Control


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/main_menu/main_menu.tscn")
