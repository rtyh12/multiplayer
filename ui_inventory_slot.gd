extends Control


@export var border: Panel

var is_selected: bool = false:
	set(new):
		is_selected = new
		border.visible = is_selected