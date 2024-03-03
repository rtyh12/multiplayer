extends SubViewportContainer


@export var settings: Node

func _ready() -> void:
	stretch_shrink = settings.scale