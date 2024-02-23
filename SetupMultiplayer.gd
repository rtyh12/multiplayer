extends Node


@export var spawn_path: Node
@export var robot_scene: PackedScene

var peer := ENetMultiplayerPeer.new()
var is_server := OS.get_cmdline_args().has("server")

# var IP_ADDRESS := "fairydust.cc"
var IP_ADDRESS := "172.22.226.71"
var PORT := 3000

func _ready() -> void:
	if is_server:
		peer.create_server(PORT)
		print("server")
	else:
		peer.create_client(IP_ADDRESS, PORT)

	print("poop")
	multiplayer.multiplayer_peer = peer
	peer.peer_connected.connect(peer_connected)

func peer_connected(id: int):
	if is_server:
		print("penis ", id)

	c_request_join.rpc(peer.get_unique_id())

@rpc("any_peer")
func c_request_join(peer_id: int):
	if not is_server:
		return
	print(peer_id, " requested join")
	var robot = robot_scene.instantiate()
	await get_tree().create_timer(1).timeout
	robot.name = "player_" + str(peer_id)
	spawn_path.add_child(robot, true)
	s_request_join_response.rpc(true)

@rpc("any_peer")
func s_request_join_response(success: bool):
	print("join response was: ", success)
	if is_server:
		return
	if not success:
		print("server refused join idk lol")
		return
	# var robot = robot_scene.instantiate()
	# spawn_path.add_child(robot)
	# robot.set_multiplayer_authority(peer.get_unique_id())
	