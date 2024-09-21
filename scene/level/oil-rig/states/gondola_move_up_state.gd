extends State

@export var _top_reach_duration_secs: float = 2.0
@export var _gondola: Gondola
@export var _tower: Tower
@export var _hang_state: State

@onready var _init_pos: Vector2 = _gondola.bottom_pos()

func enter() -> void:
  var move_tween := create_tween()

  move_tween.tween_property(
    _gondola,
    "global_position:y",
    _init_pos.y - _tower.height,
    _top_reach_duration_secs
  )

  await move_tween.finished

  _gondola.finished.emit()
  change_state.emit(_hang_state)
  pass
