class_name Tower
extends Node2D

signal began_ride(with_force: float)
signal finished(height: float)
signal height_changed

@export var target_force: float = 1000
@export var minimum_score: float = 0.2:
    set(_v):
        minimum_score = _v
        height_changed.emit()
        
@export_range(0.0, 1000) var height: int = 100:
    set(_v):
        height = _v
        height_changed.emit()

@export var bottom_pos_y: int = 0:
    set(_v):
        bottom_pos_y = _v
        height_changed.emit()

@export_category("References")
@export var gondola: Gondola


func _ready() -> void:
  gondola.finished.connect(_on_gondola_ride_finished)


func begin_ride(with_force: float) -> void:
  with_force = min(target_force, with_force)
  began_ride.emit(with_force)
  pass


func calculate_popularity_score(reached_height: float) -> float:
  var factor = 1 / pow(height, 2)
  print("Height: %f. Desired: %f" % [reached_height, height])
  var score = factor*pow(reached_height, 2)
  print("Score calculated: %f" % score)
  return score


func calculate_height_with_specific_popularity_score(score: float):
    var factor = 1/pow(height, 2)
    return sqrt(score/factor)


func _on_gondola_ride_finished(reached_height: float) -> void:
  print("finish")
  var popularity_score := calculate_popularity_score(reached_height)

  if popularity_score < minimum_score:
    LifeManager.take_life()

  finished.emit(popularity_score)
