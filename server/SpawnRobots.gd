extends GridContainer


@export var robot: PackedScene

func _ready() -> void:
	if OS.has_feature("dedicated_server") or OS.has_feature("Server"):
		# for i in range(24):
		await get_tree().create_timer(10).timeout
		while true:
			print("spawning robot")
			add_child(robot.instantiate(), true)
			await get_tree().create_timer(1).timeout