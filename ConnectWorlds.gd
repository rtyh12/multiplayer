extends Node3D


@export var solar_system: Node3D
@export var sun: Node3D

func _process(_delta):
	# var rot = Quaternion.from_euler(Vector3(0, 0, -PI/2))
	# sun.look_at(-solar_system.sun_direction * rot)
	# print(-solar_system.sun_direction * rot)
	# Quaternion.
	# sun.rotate_object_local(Vector3.LEFT, PI / 2)
	var camera = get_viewport().get_camera_3d()
	if camera:
		solar_system.camera.global_rotation = camera.global_rotation
		solar_system.camera.fov = camera.fov
