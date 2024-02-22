extends TextureRect


var IP_ADDRESS := "fairydust.cc"
# var IP_ADDRESS := "159.89.20.135"
var PORT = 3000

@export var is_on := true:
	set(new):
		is_on = new
		modulate = Color.WHITE if is_on else Color.BLACK


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_on = not is_on