class_name Gondola
extends Node2D

signal top_reached
signal finished(reached_height: float)

@export var mass_kg: float = 100.0
@export var _top: Marker2D
@export var _bottom: Marker2D

@export_category("References")
@export var tower: Tower

var reached_height: float

func _on_ride_finish() -> void:
  finished.emit(reached_height)
  pass


## Returns the top global position of the gondola.
func top_global_pos() -> Vector2:
  return _top.global_position


## Returns the bottom global position of the gondola.
func bottom_pos() -> Vector2:
  return _bottom.global_position


## Returns the height of the gondola.
func height() -> float:
  return _bottom.position.y - _top.position.y
