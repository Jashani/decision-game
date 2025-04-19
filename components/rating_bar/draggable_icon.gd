class_name DraggableIcon
extends TextureButton

var value = 0.0
var index = -1


func start_drag():
	z_index = 1
	modulate.a = 0.7


func end_drag():
	z_index = 0
	modulate.a = 1.0
