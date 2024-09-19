extends Gondola

@export var _start_height: float = 12

@export var _hoist_state_machine: StateMachine
@export var _idle_state: State
@export var _up_state: State

var acceleration: float = 0

func _ready() -> void:
    position.y-=_start_height

func begin_ride(mammoth_acceleration: float) -> void:
    acceleration = mammoth_acceleration
    _hoist_state_machine.change_state(_up_state)

func end_ride(wait: float) -> void:
    _hoist_state_machine.change_state(_idle_state)
    
    await get_tree().create_timer(wait).timeout
    finished.emit(reached_height, seats_occupied)
