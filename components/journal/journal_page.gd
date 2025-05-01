class_name JournalPage

extends Control


@export var title: String = "Title"
var entries: VBoxContainer = null


func _ready() -> void:
	_set_title()
	entries = find_child("Entries")
	#demo_journal_page()


func _set_title() -> void:
	var title_label: Label = find_child("Title")
	title_label.text = title


func add_entry(entry: Control, save: bool = true) -> void:
	entries.add_child(entry)
	if save:
		_save_entry(entry)


func add_entries(entries: Array[Control], save: bool = true) -> void:
	for entry in entries:
		add_entry(entry, save)


func _save_entry(entry: Control) -> void:
	JournalData.add_entry(title, entry)


func add_text_entry(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	add_entry(label)


func add_separator_line() -> void:
	var separator = HSeparator.new()
	add_entry(separator)


func demo_journal_page() -> void:
	add_text_entry("Hello!")
	add_text_entry("My name is Kiki. I am going to write two lines in this entry.\nThis is the second line.")
	add_separator_line()
	add_text_entry("Sometimes, I dream about cheese.")
