extends Node


signal on_select_inventory_slot(slot: int)

signal on_click_item()
signal on_inventory_changed(items: Array)
signal on_throw_item(selected_item: int)

@rpc
func s_notify_inventory_changed(items: Array):
    on_inventory_changed.emit(items)

@rpc("any_peer")
func c_request_slot_select(selected_slot: int):
    var setup_multiplayer = get_node("/root/Main/SubViewportContainer/SubViewport/Game/NearWorld/SubViewport/near_world/SetupMultiplayer")
    var sender_id = multiplayer.get_remote_sender_id()
    var player = setup_multiplayer.get_player_node_from_unique_id(sender_id)
    print("c_request_slot_select")
    player.inventory_container_path.selected_slot = selected_slot