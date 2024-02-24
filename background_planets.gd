extends Node3D


@export var camera: Camera3D
@export var sun: Node3D

var sun_direction: Vector3

func _process(_delta):
	sun_direction = sun.global_position - camera.global_position
