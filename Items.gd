extends Node3D


@onready var msgbus_inventory := $"/root/MsgbusInventory"

func give_item(item_scene_path: String, player_id: int):
	if !is_multiplayer_authority():
		return
		
	var player = get_node("../SetupMultiplayer").get_player_node_from_unique_id(player_id)
	var inventory_items = player.inventory_container_path.inventory_items
	var free_slot_index = inventory_items.find(null)
	if free_slot_index == -1:
		print("Attempted to give player ", player_id, " an item, but their inventory was full")
		return

	var item = load(item_scene_path).instantiate()
	add_child(item, true)
	inventory_items[free_slot_index] = item.get_path()
	handoff.rpc(item.get_path(), player_id)
	msgbus_inventory.s_notify_inventory_changed.rpc_id(player_id, inventory_items)


@rpc("call_local")
func handoff(node_path, auth_id):
	var node = null
	while true:
		node = get_node_or_null(node_path)
		if node != null: break
		await get_tree().create_timer(0.2).timeout

	node.set_multiplayer_authority(auth_id)