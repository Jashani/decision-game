extends Control


var first_selection: bool = true
@onready var current_selection_label: Label = $CurrentSelectionLabel
@onready var confirmation_popup: ConfirmationPopup = $ConfirmationPopup
@onready var confirm_button: Button = $ConfirmButton
@onready var confirm_label: Label = $ConfirmButton/ConfirmLabel


func _character_selected(character: String) -> void:
	if first_selection:
		confirm_button.disabled = false
		confirm_label.hide()
		first_selection = false
	
	current_selection_label.text = "Currently selected: " + character


func _on_character_1_pressed() -> void:
	_character_selected("Character 1")


func _on_character_2_pressed() -> void:
	_character_selected("Character 2")


func _on_character_3_pressed() -> void:
	_character_selected("Character 3")


func _on_character_4_pressed() -> void:
	_character_selected("Character 4")


func _on_confirm_button_pressed() -> void:
	_display_confirmation_popup()


func _selected_character_is_leaker() -> bool:
	push_error("Leaker validation is not implemented.")
	return false


func _on_confirmation_popup_yes_pressed() -> void:
	if _selected_character_is_leaker():
		get_tree().change_scene_to_file("res://stages/4_reveal/reveal_success.tscn")
	else:
		get_tree().change_scene_to_file("res://stages/4_reveal/reveal_failure.tscn")


func _on_confirmation_popup_no_pressed() -> void:
	_hide_confirmation_popup()


func _display_confirmation_popup() -> void:
	confirmation_popup.show()


func _hide_confirmation_popup() -> void:
	confirmation_popup.hide()
