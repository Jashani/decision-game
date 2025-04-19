extends Control


func _on_submit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stages/2_investigation/investigation.tscn")
