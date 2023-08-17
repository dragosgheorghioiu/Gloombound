extends Button
var button_text: String
var hoverStyle = theme.get_stylebox("hover", "Button")
var normalStyle = theme.get_stylebox("normal", "Button")


func _ready():
	hoverStyle = theme.get_stylebox("hover", "Button")
	normalStyle = theme.get_stylebox("normal", "Button")
func _process(_delta):
	if self.has_focus():
		self.theme.set_stylebox("normal", "Button", hoverStyle)
	else:
		self.theme.set_stylebox("normal", "Button", normalStyle)
