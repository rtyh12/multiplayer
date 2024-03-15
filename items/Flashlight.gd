extends Node3D


@export var flashlight_is_on: bool:
	set(new):
		if light == null:
			return

		flashlight_is_on = new
		light.visible = new

@export var light: Light3D

func click():
	# TODO maybe refactor so if !authority it never gets the click signal in the first place?
	if !is_multiplayer_authority():
		return

	flashlight_is_on = !flashlight_is_on

func _ready():
	print("ready1")
	flashlight_is_on = flashlight_is_on
	print("ready2")