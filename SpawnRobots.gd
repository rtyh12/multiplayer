extends GridContainer


@export var robot: PackedScene

func _ready() -> void:
	print("SPAWN ROBOTS!!!!")
	
	if not OS.get_cmdline_args().has("server"):
		return

	while true:
		for i in range(24):
			print("spawning robot")
			add_child(robot.instantiate(), true)
			await get_tree().create_timer(1).timeout
		for n in get_children():
			remove_child(n)
			n.queue_free()
