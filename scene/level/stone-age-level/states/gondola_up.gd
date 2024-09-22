class_name StoneAgeGondolaUpState
extends State

@export var _tower: Tower
@export var _move_component: MoveComponent
@export var _idle_state: State
@export var _gondola: Gondola

# @onready var _init_height: float = global_position.y

var acceleration_y: float = 0.0
var _init_pos: Vector2 = Vector2.ZERO

func enter() -> void:
    
