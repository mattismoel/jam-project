@tool
class_name ContainerComponent
extends Node2D

@export var _shape: Shape2D:
  set(_v):
    if !_v is CircleShape2D && !_v is RectangleShape2D:
      push_warning("Invalid shape. Must be RectangleShape2D or CircleShape2D")
      return

    _shape = _v

    if _shape == null:
      return

    if !_shape.changed.is_connected(queue_redraw):
      _shape.changed.connect(queue_redraw)

    queue_redraw()


@export var _debug_color: Color = Color.MEDIUM_BLUE:
  set(_v):
    _debug_color = _v
    queue_redraw()


@export var _transparency: float = 0.2:
  set(_v):
    _transparency = _v
    queue_redraw()


func _draw() -> void:
  if !Engine.is_editor_hint():
    return

  _shape.draw(get_canvas_item(), Color(_debug_color.r, _debug_color.g, _debug_color.b, _transparency))


