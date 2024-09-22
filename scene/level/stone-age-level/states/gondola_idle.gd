extends State

@export var _up_state: StoneAgeGondolaUpState
@export var _tower: Tower
@export var _move_component: MoveComponent

func _ready() -> void:
  _tower.began_ride.connect(_on_tower_began_ride)


func enter() -> void:
  _move_component.velocity = Vector2.ZERO


func _on_tower_began_ride(with_force: float) -> void:
  _up_state.acceleration_y = with_force
  change_state.emit(_up_state)
