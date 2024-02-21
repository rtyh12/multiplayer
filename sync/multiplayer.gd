extends Node2D


var PORT = 3000
var MAX_CLIENTS = 10


var black := false:
	set(new_black):
		black = new_black
		modulate = Color.BLACK if new_black else Color.WHITE


func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	
	print("server up")

	multiplayer.peer_connected.connect(peer_connected.bind())
	

@rpc("any_peer")
func change_color_request(new_black: bool):
	change_color_response.rpc(new_black)


@rpc("any_peer")
func change_color_response(new_black: bool):
	print("i am server")


func peer_connected(id: int):
	print("penis ", id)