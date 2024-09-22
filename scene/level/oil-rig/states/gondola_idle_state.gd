extends State

@export var _tower: Tower
@export var _move_up_state: State
@export var _move_component: MoveComponent

func _ready() -> void:
  _tower.began_ride.connect(_on_tower_began_ride)


func enter() -> void:
  _move_component.velocity = Vector2.ZERO


func _on_tower_began_ride(with_force: float) -> void:
  change_state.emit(_move_up_state)
  pass
