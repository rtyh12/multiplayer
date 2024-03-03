extends Node


func toggle_fullscreen():
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_FULLSCREEN

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# toggle_fullscreen()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("full_screen"):
		toggle_fullscreen()