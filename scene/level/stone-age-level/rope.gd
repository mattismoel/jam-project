extends Line2D

const GONDOLA_KNOT_IDX: int = 0
const MAMMOTH_KNOT_IDX: int = 3

@export var _gondola_end: Node2D
@export var _mammoth: Node2D

func _process(delta: float) -> void:
      set_point_position(GONDOLA_KNOT_IDX, _gondola_end.global_position - global_position)
      set_point_position(MAMMOTH_KNOT_IDX, Vector2(_mammoth.position.x, get_point_position(MAMMOTH_KNOT_IDX).y))
      pass
