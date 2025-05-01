extends Control


@onready var journal: Journal = find_child("Journal")


func _on_submit_button_pressed() -> void:
	journal.case_page.add_text_entry("We've seen some suspects!")
	journal.suspects_page.add_text_entry("We've learned important information about each suspect. I just didn't write it down.")
	journal.suspects_page.add_text_entry("I think one of them looked like this:")
	var suspect_image: TextureRect = TextureRect.new()
	suspect_image.texture = load("res://sprites/icon.svg")
	suspect_image.stretch_mode = TextureRect.STRETCH_KEEP
	journal.suspects_page.add_entry(suspect_image)
	get_tree().change_scene_to_file("res://stages/2_investigation/investigation.tscn")
