class_name Journal

extends Control


@onready var case_page: JournalPage = find_child("Case")
@onready var suspects_page: JournalPage = find_child("Suspects")


func _ready() -> void:
	var case_entries: Array[Control] = JournalData.load_entries(case_page.title)
	var suspects_entries: Array[Control] = JournalData.load_entries(suspects_page.title)
	case_page.add_entries(case_entries, false)
	suspects_page.add_entries(suspects_entries, false)
	#demo_journal()


func _on_exit_background_button_pressed() -> void:
	self.hide()


func demo_journal() -> void:
	var label: Label = create_label_with_text("This is a case, indeed! And a peculiar one certainly!")
	case_page.add_entry(label)
	
	var label2: Label = create_label_with_text("There are suspects!!!!! Certainly!!!!!")
	suspects_page.add_entry(label2)


func create_label_with_text(text: String) -> Label:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	return label
