extends Node3D


@export var light: Light3D

func click():
	if is_multiplayer_authority():
		light.visible = not light.visible