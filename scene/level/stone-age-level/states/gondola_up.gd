class_name StoneAgeGondolaUpState
extends State

@export var _tower: Tower
@export var _move_component: MoveComponent
@export var _idle_state: State
@export var _gondola: Gondola

# @onready var _init_height: float = global_position.y

var acceleration_y: float = 0.0
var _init_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
  _tower.began_ride.connect(_on_tower_began_ride)


func enter() -> void:
    _init_pos = _gondola.global_position


func physics_process(_delta: float) -> void:
  _move_component.velocity += Vector2.UP * acceleration_y
  print(_gondola.global_position.y)

  if _gondola.global_position.y <= _init_pos.y - _tower.tower_stat.desired_height:
        _gondola.top_reached.emit()
        _gondola.reached_height = _init_pos.y - _gondola.global_position.y
        change_state.emit(_idle_state)
  pass


func _on_tower_began_ride(with_force: float) -> void:
  acceleration_y = with_force
  pass
