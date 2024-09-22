extends State


@export var _gondola: Gondola
@export var _hang_duration_secs: float = 2.0
@export var _fall_state: State

func enter() -> void:
  _gondola.reached_height = _gondola.global_position.y
  await get_tree().create_timer(_hang_duration_secs).timeout
  change_state.emit(_fall_state)
