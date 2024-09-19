extends State

@export var _rope: VerletRope
@export var _pipe_end: Node2D

var _mouse_pos: Vector2

func process(delta: float) -> void:
  if Engine.is_editor_hint():
    return

  _mouse_pos = get_global_mouse_position()

  _rope.set_end(_mouse_pos)
  _pipe_end.global_position = _mouse_pos

  var dir = _rope.start_pos().direction_to(_rope.end_pos())
  _pipe_end.rotation = dir.angle()
  pass
