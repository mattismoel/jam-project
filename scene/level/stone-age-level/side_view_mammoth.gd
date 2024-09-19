extends Node2D

@export var _mammoth_state_machine: StateMachine
@export var _idle_state: State
@export var _walk_state: State
@export var _animation: AnimatedSprite2D

var acceleration: float = 0

func begin_pull(given_acceleration: float) -> void:
    acceleration = given_acceleration
    _animation.play()
    _mammoth_state_machine.change_state(_walk_state)

func stop_pull() -> void:
    _animation.stop()
    _mammoth_state_machine.change_state(_idle_state)
