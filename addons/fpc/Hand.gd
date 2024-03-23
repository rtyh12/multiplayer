extends Node3D


@onready var pooled_items_parent := get_node("../../../Items")

@export var hand_target: Node3D

@export var inventory_items: Array
@export var player_root: Node
@onready var msgbus_inventory := $"/root/MsgbusInventory"

@export var selected_slot: int:
	set(new):
		selected_slot = new
		# print(selected_slot, " sel - new ", new)
		for i in len(inventory_items):
			if inventory_items[i] == null or inventory_items[i].is_empty(): return
			var item = get_node(inventory_items[i])
			if item == null: return
			item.visible = i == selected_slot

func _enter_tree() -> void:
	set_multiplayer_authority(1)

func _ready():
	if player_root.is_current_player():
		msgbus_inventory.on_select_inventory_slot.connect(_on_select_inventory_slot)
		msgbus_inventory.on_click_item.connect(_on_click_item)
		msgbus_inventory.on_throw_item.connect(_on_throw_item)
	
	if !is_multiplayer_authority():
		return

	var flashlight = "res://items/flashlight.tscn"
	var almond = "res://items/cone.tscn"

	inventory_items = [null, null, null, null]

	pooled_items_parent.give_item(flashlight, player_root.get_peer_id())
	pooled_items_parent.give_item(almond, player_root.get_peer_id())
	pooled_items_parent.give_item(flashlight, player_root.get_peer_id())
	pooled_items_parent.give_item(almond, player_root.get_peer_id())
	pooled_items_parent.give_item(flashlight, player_root.get_peer_id())

# TODO
func _child_entered_tree(node: Node):
	node.set_multiplayer_authority(get_multiplayer_authority())

func _on_select_inventory_slot(slot: int):
	if !is_multiplayer_authority():
		return

	selected_slot = slot

func _on_click_item(slot: int):
	var item_path = inventory_items[slot]
	if item_path == null or item_path.is_empty(): return
	var item = get_node(item_path)
	
	if !item.is_multiplayer_authority() \
	or !item.has_method("click"):
		return

	item.click()

func _on_throw_item(selected_slot: int):
	if !is_multiplayer_authority():
		return

	var item_path = inventory_items[selected_slot]
	if item_path == null or item_path.is_empty(): return
	var item = get_node(item_path)
	
	print("would delete ", item)

func _process(delta):
	global_rotation = hand_target.global_rotation
	global_position = lerp(global_position, hand_target.global_position, 0.4)

	for item_path in inventory_items:
		if item_path == null or item_path.is_empty(): return
		var item = get_node(item_path)
		
		item.global_position = global_position
		item.global_rotation = global_rotation