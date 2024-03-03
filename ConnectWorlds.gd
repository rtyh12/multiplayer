extends Node3D


@export var solar_system: Node3D
@export var local_sun: DirectionalLight3D

@export var solar_system_position: Vector3

func _process(_delta):
	# var rot = Quaternion.from_euler(Vector3(0, 0, -PI/2))
	# sun.look_at(-solar_system.sun_direction * rot)
	# print(-solar_system.sun_direction * rot)
	# Quaternion.
	# sun.rotate_object_local(Vector3.LEFT, PI / 2)
	local_sun.global_rotation = solar_system.sun.global_rotation
	var camera = get_viewport().get_camera_3d()
	if camera:
		solar_system.camera.global_rotation = camera.global_rotation
		solar_system.camera.fov = camera.fov
	local_sun.visible = solar_system.light_is_on

func _physics_process(_delta):
	if OS.get_cmdline_args().has("server"):
		var orbital_period = 90 * 60
		var t = Time.get_ticks_msec() / 1000.
		var start_pos = Vector3.LEFT * (6300 + 3000)
		var now_pos = start_pos.rotated(Vector3.UP, 2 * PI * t / orbital_period)
		solar_system_position = now_pos

	solar_system.camera.global_position = solar_system_position * 1e-4