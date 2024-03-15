extends ColorRect


@export var settings: Node

func _ready() -> void:
	material.set_shader_parameter("scale", settings.scale)