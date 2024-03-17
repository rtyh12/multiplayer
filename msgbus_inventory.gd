extends Node


signal on_select_inventory_slot(slot: int)

signal on_click_item()
signal on_inventory_changed(items: Array)
signal on_throw_item(selected_item: int)