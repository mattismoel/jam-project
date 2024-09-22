extends State

@export var _fall_duration: float = 0.8
@export var _gondola: Gondola
@export var _tower_bottom: Node2D
@export var _idle_state: State


func enter() -> void:
  var tween := create_tween()

  tween.tween_property(
    _gondola,
    "global_position:y",
    _tower_bottom.global_position.y - _gondola.height() / 2.0,
    _fall_duration,
  )\
  .set_ease(Tween.EASE_IN)\
  .set_trans(Tween.TRANS_QUINT)

  await tween.finished

  _gondola.finished.emit(_gondola.reached_height)
  change_state.emit(_idle_state)
  pass
