extends Node2D


var speed = 500

@export var is_on := true:
	set(new):
		is_on = new
		modulate = Color.WHITE if is_on else Color.BLACK

func _enter_tree():
	var peer_id_str = name.split("_")[1]
	set_multiplayer_authority(int(peer_id_str))

func _physics_process(delta):
	if not is_multiplayer_authority():
		return
	
	if Input.is_action_pressed("space"):
		is_on = not is_on
	
	var vec = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += vec * speed * delta

	# if OS.get_cmdline_args().has("server"):
	# 	print(position)