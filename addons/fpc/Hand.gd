extends Node3D


@onready var items_path := get_node("../../../Items")

@export var hand_target: Node3D
@export var spawn_target: Node3D
@onready var msgbus_inventory := $"/root/MsgbusInventory"

@export var selected_slot: int:
	set(new):
		selected_slot = new
		# TODO all of this feels kinda hacky...
		var items = spawn_target.get_children() as Array[Node3D]
		for item in items:
			item.visible = item.name.to_int() == selected_slot

func _ready():
	multiplayer.allow_object_decoding = true
	
	spawn_target.connect("child_entered_tree", _child_entered_tree)
	
	msgbus_inventory.on_select_inventory_slot.connect(_on_select_inventory_slot)
	msgbus_inventory.on_click_item.connect(_on_click_item)
	msgbus_inventory.on_throw_item.connect(_on_throw_item)

	var flashlight = load("res://items/flashlight.tscn")
	var almond = load("res://items/cone.tscn")

	if !is_multiplayer_authority():
		return

	var item1 = flashlight.instantiate()
	var item2 = almond.instantiate()
	var item3 = flashlight.instantiate()
	var item4 = almond.instantiate()
	item1.name = "0"
	item2.name = "1"
	item3.name = "2"
	item4.name = "3"
	# item1.set_multiplayer_authority(get_multiplayer_authority())
	spawn_target.add_child(item1)
	spawn_target.add_child(item2)
	spawn_target.add_child(item3)
	spawn_target.add_child(item4)
	# item2.set_multiplayer_authority(get_multiplayer_authority())
	# item3.set_multiplayer_authority(get_multiplayer_authority())
	# item4.set_multiplayer_authority(get_multiplayer_authority())
		
	msgbus_inventory.emit_signal("on_inventory_changed", spawn_target.get_children())

func _child_entered_tree(node: Node):
	node.set_multiplayer_authority(get_multiplayer_authority())

func _on_select_inventory_slot(slot: int):
	if !is_multiplayer_authority():
		return

	selected_slot = slot

func _on_click_item(slot: int):
	if !is_multiplayer_authority():
		return

	var item = spawn_target.get_node_or_null(str(slot))
	if item == null:
		return
		
	if item.has_method("click"):
		item.click()

func _on_throw_item(selected_slot: int):
	if !is_multiplayer_authority():
		return

	var item = spawn_target.get_node_or_null(str(selected_slot))
	if item == null:
		return
	
	items_path.c_request_item_spawn.rpc(item, item.global_position)
	item.queue_free()

func _process(delta):
	global_rotation = hand_target.global_rotation
	global_position = lerp(global_position, hand_target.global_position, 0.4)
	# print("------------------")
	# print(get_multiplayer_authority())
	# print(spawn_target.get_children())
	# if len(spawn_target.get_children()) == 0:
	# 	return
	# print(spawn_target.get_children()[0].get_multiplayer_authority())