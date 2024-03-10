extends Node3D


@onready var msgbus_inventory := $"/root/MsgbusInventory"
var instantiated_item: Node3D

func _ready():
	msgbus_inventory.connect("on_select_inventory_slot", _on_select_inventory_slot)
	msgbus_inventory.connect("on_click_item", _on_click_item)

func _on_select_inventory_slot(item: Item):
	if instantiated_item:
		instantiated_item.free()
	instantiated_item = item.scene.instantiate()
	instantiated_item.set_multiplayer_authority(get_multiplayer_authority())
	add_child(instantiated_item)
	print(item.id)

func _on_click_item():
	if not instantiated_item:
		return
	if instantiated_item.has_method("click"):
		instantiated_item.click()