extends CanvasLayer

@export var _game_over_label: TypedLabel
@export var _score_label: TypedLabel

func _ready() -> void:
  _game_over_label.finished.connect(_on_game_over_type_finish)


func _on_game_over_type_finish() -> void:
  var _score := ScoreManager.average_score()
  _score_label.text = "Finished with %.2f%% satistfaction." % (_score * 100.0)
  _score_label.start()


