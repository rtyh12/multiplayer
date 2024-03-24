extends Node3D


@export var camera: Camera3D
@export var sun: DirectionalLight3D
@export var sun_sprite: Sprite3D

var sun_intensity: float:
	set(new):
		sun_intensity = new
		sun_sprite.modulate = Color(1, 1, 1, sun_intensity)

var light_is_on: bool = true:
	set(new):
		light_is_on = new
		var target_intensity = 1 if light_is_on else 0
		var tween = get_tree().create_tween()
		tween.tween_property(self, "sun_intensity", target_intensity, 15)

func _physics_process(_delta: float) -> void:
	var space_state = camera.get_world_3d().get_direct_space_state()
	var raycast_params = PhysicsRayQueryParameters3D.create(
		camera.global_position,
		sun_sprite.global_position)
	var raycast = space_state.intersect_ray(raycast_params)
	light_is_on = raycast.is_empty()