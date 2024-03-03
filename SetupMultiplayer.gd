extends Node

@export var spawn_path: Node
@export var world_root: Node
@export var robot_scene: PackedScene

@export var heartbeat_interval = 1
@export var heartbeat_timeout = 30

var peer := ENetMultiplayerPeer.new()
var is_server := OS.get_cmdline_args().has("server")

var IP_ADDRESS := "fairydust.cc"
# var IP_ADDRESS := "172.22.226.71"
var PORT := 3000

var s_clients = {}

func _ready() -> void:
	if is_server:
		peer.create_server(PORT)
		print("LAUNCHED SERVER ON PORT ", PORT)
		start_heartbeat()
	else:
		peer.create_client(IP_ADDRESS, PORT)

	multiplayer.multiplayer_peer = peer
	peer.peer_connected.connect(peer_connected)
	peer.peer_disconnected.connect(peer_disconnected)


func peer_connected(id: int):
	if is_server:
		print("penis ", id)
		s_clients[id] = { "time_since_heartbeat_response": 0 }
		return

	c_request_join.rpc(peer.get_unique_id())


func peer_disconnected(id: int):
	s_clients.erase(id)
	var player_path = "player_" + str(id)
	var player = spawn_path.get_node(player_path)
	if player != null:
		player.queue_free()


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
	

func start_heartbeat():
	while true:
		c_acknowledge_heartbeat.rpc()
		await get_tree().create_timer(heartbeat_interval).timeout
		print("s_clients = ", s_clients)
		print("peers = ", multiplayer.get_peers())

		for peer_id in s_clients.keys():
			s_clients[peer_id]["time_since_heartbeat_response"] += heartbeat_interval
			if s_clients[peer_id]["time_since_heartbeat_response"] >= heartbeat_timeout:
				peer.disconnect_peer(peer_id)
				s_clients.erase(peer_id)


@rpc
func c_acknowledge_heartbeat():
	s_client_did_acknowledge_heartbeat.rpc_id(1, multiplayer.get_unique_id())

@rpc("any_peer")
func s_client_did_acknowledge_heartbeat(peer_id: int):
	s_clients[peer_id]["time_since_heartbeat_response"] = 0