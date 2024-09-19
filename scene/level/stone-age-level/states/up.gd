extends State

@export var _gondola: Gondola
@export var _rope: Line2D
@export var _mammoth: Node2D
var _speed: float = 0

func physics_process(delta: float) -> void:
    _speed+=_gondola.acceleration*delta
    var delta_pos=_speed*delta

    _gondola.position+=delta_pos*Vector2.UP
    _gondola.reached_height+=delta_pos

    if _gondola.reached_height>_gondola.tower.tower_stat.height-_gondola._start_height-30:
        _gondola.top_reached.emit()
