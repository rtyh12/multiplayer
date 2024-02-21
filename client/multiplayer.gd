extends Node2D


# var IP_ADDRESS := "fairydust.cc"
var IP_ADDRESS := "159.89.20.135"
var PORT = 3000


var black := false:
	set(new_black):
		black = new_black
		modulate = Color.BLACK if new_black else Color.WHITE


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		black = not black
		change_color_request.rpc(black)


func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer


@rpc
func change_color_request(new_black: bool):
	print("i am client")


@rpc
func change_color_response(new_black: bool):
	print("change_color_response")
	black = new_black
