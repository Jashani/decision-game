extends Control


@onready var journal: Journal = find_child("Journal")


func _on_submit_button_pressed() -> void:
	journal.case_page.add_text_entry("We've interrogated our suspects!")
	journal.suspects_page.add_text_entry("The suspects said a bunch of things—but I forget...")
	get_tree().change_scene_to_file("res://stages/3_choose/choose_leaker.tscn")
