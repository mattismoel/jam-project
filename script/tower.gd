@tool
class_name Tower
extends Node2D

signal began_ride(with_force: float)
signal finished(height: float)

@export_range(0.0, 1000) var height: int = 100:
  set(_v):
    height = _v
    queue_redraw()

@export_category("References")
@export var gondola: Gondola


func _ready() -> void:
  if Engine.is_editor_hint():
    return

  gondola.finished.connect(_on_gondola_ride_finished)


func begin_ride(with_force: float) -> void:
  began_ride.emit(with_force)
  pass


func _draw() -> void:
  _draw_height_markers()
  pass


func calculate_popularity_score(height: float) -> float:
  return height


func _on_gondola_ride_finished(height: float) -> void:
  var popularity_score := calculate_popularity_score(height)
  finished.emit(popularity_score)


func _draw_height_markers() -> void:
  if !Engine.is_editor_hint():
    return

  var offset := 24

  # Draws the height bar.
  var height_marker_start_pos := global_position - position + Vector2.LEFT * offset
  var height_marker_end_pos := height_marker_start_pos + Vector2.UP * height
  draw_line(height_marker_start_pos, height_marker_end_pos, Color.WHITE_SMOKE)
  draw_line(height_marker_end_pos, height_marker_end_pos + Vector2.RIGHT * offset, Color.WHITE_SMOKE)
