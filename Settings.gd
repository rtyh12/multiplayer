extends Node


@export var scale: int = 3:
    set(new):
        scale = new
        on_scale_changed.emit(scale)

signal on_scale_changed(scale: float)

func _ready():
    get_tree().root.size_changed.connect(_on_size_changed)
    _on_size_changed()

func _on_size_changed():
    var res = get_tree().root.size
    print(res.x / 1000)
    scale = int(res.x / 1000) + 1
    # if res.x < 1200:
    #     scale = 1
    # elif res.x < 2000:
    #     scale = 2
    # elif res.x < 3000:
    #     scale = 3
    # else:
    #     scale = 4
