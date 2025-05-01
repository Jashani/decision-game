extends Label


func _ready() -> void:
	self.text = "Score: " + str(Global.score)
