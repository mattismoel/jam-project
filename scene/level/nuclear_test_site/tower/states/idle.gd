extends State

@export var _drop_state: State


func _ready() -> void:
  SignalBus.lever_pulled.connect(_on_lever_pulled)


func _on_lever_pulled() -> void:
  change_state.emit(_drop_state)
  pass
