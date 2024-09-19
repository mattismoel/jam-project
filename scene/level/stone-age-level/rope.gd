extends Line2D

@export var _gondola: Gondola
@export var _mammoth: Node2D

func _process(delta: float) -> void:
    var correction = Vector2(-3, 108) #rope.position-rope.get_point_position(0)
    set_point_position(0, correction+_gondola.position)
    set_point_position(3, Vector2(_mammoth.position.x, get_point_position(3).y))
