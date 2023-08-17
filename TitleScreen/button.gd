extends Button

func _process(_delta):
	if self.is_hovered():
		self.grab_focus()
