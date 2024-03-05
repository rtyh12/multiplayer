extends Node2D


@export var generated_rooms_container: Node2D
@export var possible_rooms_container: Node2D
@export var tile_map: TileMap

var possible_doors = []
var possible_rooms: Array[Node]:
	get:
		var out: Array[Node] = []
		for room in possible_rooms_container.get_children():
			if room.visible:
				out.append(room)
		return out

func mark_cell_status(rect: Rect2i, status: int):
	for x in range(rect.position.x, rect.end.x):
		for y in range(rect.position.y, rect.end.y):
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, status))

func get_cell_status(coords: Vector2i):
	return tile_map.get_cell_atlas_coords(0, coords).y

func colliding_with_rect(rect: Rect2i):
	for x in range(rect.position.x, rect.end.x):
		for y in range(rect.position.y, rect.end.y):
			if get_cell_status(Vector2i(x, y)) == 1:
				return true
	return false

func get_params_for_door(door: Node2D) -> Vector3i:
	var pos = door.global_position.round()
	var rot = round(door.rotation_degrees)
	return Vector3i(pos.x, pos.y, rot)

func get_empty_doors():	
	var rooms = generated_rooms_container.get_children()
	var all_doors = []
	for room in rooms:
		for door in room.get_node("doors").get_children():
			if door.free:
				all_doors.append(door)
	return all_doors

func get_generated_rooms_boxes():
	var rooms = generated_rooms_container.get_children()
	var all_boxes = []
	for room in rooms:
		for box in room.get_node("boxes").get_children():
			all_boxes.append(box)
	return all_boxes

func _ready() -> void:
	for room in possible_rooms:
		possible_doors.append_array(room.get_node("doors").get_children())

	var max_room_count = 100
	var generated_room_count = 0
	while true:
		var generated_at_least_one_room_this_iteration = false
		for empty_door in get_empty_doors():
			var possible_rooms_shuffled = possible_rooms
			possible_rooms_shuffled.shuffle()
			# TODO change possible rooms to possible doors
			for possible_room in possible_rooms_shuffled:
				# attempt to generate room
				var new_room = possible_room.duplicate(DUPLICATE_GROUPS + DUPLICATE_SIGNALS + DUPLICATE_SCRIPTS)
				var new_door = new_room.get_node("doors").get_children().pick_random()
				generated_rooms_container.add_child(new_room)

				new_room.global_rotation_degrees = round(-180 + empty_door.global_rotation_degrees - new_door.global_rotation_degrees)
				new_room.global_position = (new_room.global_position - new_door.global_position + empty_door.global_position).round()

				var colliding = false
				var boxes = new_room.get_node("boxes").get_child(0).get_children()
				var new_rects_to_mark: Array[Rect2i] = []
				for box in boxes:
					var rect = box.get_shape().get_rect()
					var transformed_rect = Rect2i(
						(box.global_position + rect.position.rotated(box.global_rotation)).round(),
						rect.size.rotated(box.global_rotation).round())\
					.abs()
					if colliding_with_rect(transformed_rect):
						colliding = true
						break
					new_rects_to_mark.append(transformed_rect)

				if not colliding:
					for rect in new_rects_to_mark:
						mark_cell_status(rect, 1)
					
				if colliding:
					# abort abort abort abort 🚨🚨🚨	
					new_room.free()
					continue
				else:
					# success; add room
					empty_door.free = false
					new_door.free = false
					generated_room_count += 1
					generated_at_least_one_room_this_iteration = true
					if generated_room_count >= max_room_count:
						return
					break

		if not generated_at_least_one_room_this_iteration:
			return