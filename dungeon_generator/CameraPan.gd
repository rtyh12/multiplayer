extends Node2D


@export var speed: float

func _physics_process(_delta):
    var input_direction = Input.get_vector(
        "move_left", "move_right", "move_up", "move_down")
    var sprint = 2 if Input.is_action_pressed("sprint") else 1
    position += input_direction * speed * sprint
