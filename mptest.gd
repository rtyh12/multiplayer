extends Node3D


@export var test: int
@export var test_arr: Array[int]
@export var test_untyped_arr: Array
@export var test_path: NodePath
@export var test_path_arr: Array[NodePath]
@export var test_path_untyped_arr: Array

# func _enter_tree() -> void:
# 	set_multiplayer_authority(1)

func _ready():
	if !is_multiplayer_authority():
		return
	
	test = 5
	test_arr = [1, 2, 3]
	test_untyped_arr = [4, 5, 6]
	test_path = NodePath("/root/hello")
	test_path_arr = [NodePath("/root/hello"), NodePath("/root/bye")]
	test_path_untyped_arr = [NodePath("/root/hello1"), NodePath("/root/bye2")]