extends Node


var peer := ENetMultiplayerPeer.new()

# var IP_ADDRESS := "fairydust.cc"
var IP_ADDRESS := "172.22.226.71"
var PORT := 3000

func _ready() -> void:
	print(OS.has_feature("headless"))
	if OS.has_feature("dedicated_server") or OS.has_feature("Server"):
		peer.create_server(PORT)
		print("server")
	else:
		peer.create_client(IP_ADDRESS, PORT)

	print("poop")
	multiplayer.multiplayer_peer = peer
	peer.peer_connected.connect(peer_connected)

func peer_connected(id: int):
	print("penis ", id)