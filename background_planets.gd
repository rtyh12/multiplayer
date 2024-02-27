extends Node3D


@export var camera: Camera3D
@export var sun: DirectionalLight3D
@export var sun_sprite: Sprite3D

var light_is_on: bool

func _physics_process(_delta: float) -> void:
	var space_state = camera.get_world_3d().get_direct_space_state()
	var raycast_params = PhysicsRayQueryParameters3D.create(
		camera.global_position,
		sun_sprite.global_position)
	var raycast = space_state.intersect_ray(raycast_params)
	light_is_on = raycast.is_empty()
	sun_sprite.visible = light_is_on