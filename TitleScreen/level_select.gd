extends Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.visible == true:
		grab_focus()
