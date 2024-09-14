class_name ScoreManager
extends Node

signal score_added(score: float)


@export var attempt_count: int = 3
@export var tower: Tower

var _scores: Array[float] = []:
  set(_s):
    if len(_s) >= attempt_count:
      _s.pop_front()


func _ready() -> void:
  tower.finished.connect(_on_ride_finished)


func _on_ride_finished(popularity_score: float) -> void:
  _scores.append(popularity_score)
  pass


func average_score() -> float:
  var sum: float = 0.0
  for score in _scores:
    sum += score

  return sum / len(_scores)


func _add_popularity_score(_score: float) -> void:
  _scores.append(_score)
  score_added.emit(_score)
