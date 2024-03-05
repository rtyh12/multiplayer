extends Node


func _ready():
	var initialize_response: Dictionary = Steam.steamInitEx(true, 480)
	print("Did Steam initialize?: %s " % initialize_response)

func _process(_delta):
	Steam.run_callbacks()