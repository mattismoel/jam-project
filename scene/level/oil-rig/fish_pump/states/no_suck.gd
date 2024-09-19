extends State

@export var _suck_state: State

func input(event: InputEvent) -> void:
  super(event)
  if event.is_action_pressed("suck"):
    change_state.emit(_suck_state)
