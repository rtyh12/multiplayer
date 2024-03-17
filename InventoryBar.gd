extends MarginContainer


@export var ui_slot_scene: PackedScene
@export var spawn_target: Control
@export var slot_count: int = 4

var slots: Array[Control]

@onready var msgbus_inventory := $"/root/MsgbusInventory"

var selected_slot: int = 0:
	set(new):
		slots[selected_slot].is_selected = false
		selected_slot = posmod(new, slot_count)
		slots[selected_slot].is_selected = true
		msgbus_inventory.emit_signal("on_select_inventory_slot", selected_slot)

func _ready():
	msgbus_inventory.connect("on_inventory_changed", _on_inventory_changed)

func _input(event):	
	if event.is_action_pressed("inventory_scroll_right"):
		selected_slot += 1
	if event.is_action_pressed("inventory_scroll_left"):
		selected_slot -= 1
	if event.is_action_pressed("throw_item"):
		msgbus_inventory.on_throw_item.emit(selected_slot)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			selected_slot += 1
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			selected_slot -= 1

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			msgbus_inventory.emit_signal("on_click_item", selected_slot)

func _on_inventory_changed(items: Array):
	for i in len(items):
		var slot = ui_slot_scene.instantiate()
		spawn_target.add_child(slot)
		slots.append(slot)
		selected_slot = selected_slot  # refresh selected slot to trigger setter