@tool
class_name Tower
extends Node2D

signal began_ride
signal finished(height: float)


@export var tower_stat: TowerStat

@export_category("References")
@export var gondola: Gondola

var force: float

func _ready() -> void:
  tower_stat.changed.connect(queue_redraw)
  gondola.finished.connect(_on_gondola_ride_finished)


func _draw() -> void:
  _draw_height_markers()
  pass


func calculate_popularity_score(passenger_count: int, height: float) -> float:
  return height / tower_stat.desired_height


func begin_ride(_force: float) -> void:
  force = _force
  gondola.begin_ride(_force)
  began_ride.emit()
  pass


func _on_gondola_ride_finished(height: float, seats_occupied: int) -> void:
  var popularity_score := calculate_popularity_score(seats_occupied, height)
  finished.emit(popularity_score)


func _draw_height_markers() -> void:
  var spacing := 8
  var offset := 24

  var anchor := global_position

  # Draws the height bar.
  var height_marker_start_pos := global_position - position + Vector2.LEFT * offset
  var height_marker_end_pos := height_marker_start_pos + Vector2.UP * tower_stat.height
  draw_line(height_marker_start_pos, height_marker_end_pos, Color.WHITE_SMOKE)
  draw_line(height_marker_end_pos, height_marker_end_pos + Vector2.RIGHT * offset, Color.WHITE_SMOKE)

  # Draws the desired height bar.
  var desired_height_marker_start_pos := global_position - position + Vector2.LEFT * (offset + spacing)
  var desired_height_marker_end_pos := desired_height_marker_start_pos + Vector2.UP * tower_stat.desired_height
  draw_dashed_line(desired_height_marker_start_pos, desired_height_marker_end_pos, Color.RED)
  draw_line(desired_height_marker_end_pos, desired_height_marker_end_pos + Vector2.RIGHT * (offset + spacing), Color.RED)
