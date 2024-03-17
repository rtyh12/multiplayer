extends Node3D


@rpc("any_peer")
func c_request_item_spawn(item: Node3D, global_pos: Vector3):
	if !is_multiplayer_authority():
		return
		
	add_child(item)
	item.global_position = global_pos
	item.set_multiplayer_authority(1)