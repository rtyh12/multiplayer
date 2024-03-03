extends TextureRect


@export var settings: Node

func _ready() -> void:
	scale = Vector2i(settings.scale, settings.scale)