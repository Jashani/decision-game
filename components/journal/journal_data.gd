extends Node


var entries = {}


# Using the title may not be the smartest approach but c'est la vie
func add_entry(page_title: String, entry: Control) -> void:
	_create_page_if_not_exist(page_title)
	var scene: PackedScene = _save_node_as_scene(entry)
	entries[page_title].append(scene)


func get_entries(page_title: String) -> Array[PackedScene]:
	_create_page_if_not_exist(page_title)
	return entries[page_title]


func load_entries(page_title: String) -> Array[Control]:
	_create_page_if_not_exist(page_title)
	var loaded_entries: Array[Control] = []
	for entry in entries[page_title]:
		var loaded_entry: Control = entry.instantiate()
		loaded_entries.append(loaded_entry)
	
	return loaded_entries


func reset_entries() -> void:
	for page in entries.keys():
		entries[page].clear()
	
 
func _create_page_if_not_exist(title: String) -> void:
	if title in entries.keys():
		return

	var page: Array[PackedScene] = []
	entries[title] = page


func _save_node_as_scene(node: Control) -> PackedScene:
	var scene = PackedScene.new()
	scene.pack(node)
	return scene
