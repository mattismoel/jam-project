extends Node

signal score_added(score: float)
signal calculated_final_score(final_score: float)

var _scores: Array[float] = []

func _ready() -> void:
  LifeManager.out_of_lives.connect(_on_life_manager_out_of_lives)

func add_popularity_score(score: float) -> void:
  _scores.append(score)


func average_score() -> float:
  var sum: float = 0.0
  for score in _scores:
    sum += score

  return sum / len(_scores)


func _add_popularity_score(_score: float) -> void:
  _scores.append(_score)
  score_added.emit(_score)


func _on_life_manager_out_of_lives() -> void:
  var final_score := average_score()
  calculated_final_score.emit(final_score)
  pass
