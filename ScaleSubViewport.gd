extends SubViewportContainer


@onready var settings := $"/root/Settings"

func _ready() -> void:
	stretch_shrink = settings.scale
	settings.on_scale_changed.connect(_on_scale_changed)

func _on_scale_changed(new_scale: float):
	stretch_shrink = int(new_scale)