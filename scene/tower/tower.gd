@tool
class_name Tower
extends Node2D

signal begin_ride
signal finished(height: float)


@export var tower_stat: TowerStat

@export_category("References")
@export var minigame: Minigame
@export var gondola: Gondola

var force: float

func _ready() -> void:
  minigame.finished.connect(_on_minigame_finished)
  gondola.finished.connect(_on_gondola_ride_finished)


func calculate_popularity_score(passenger_count: int, height: float) -> float:
  return height / tower_stat.desired_height


func _on_minigame_finished(_force: float) -> void:
  force = _force
  gondola.begin_ride(_force)
  begin_ride.emit()
  pass


func _on_gondola_ride_finished(height: float, seats_occupied: int) -> void:
  var popularity_score := calculate_popularity_score(seats_occupied, height)
  finished.emit(popularity_score)
