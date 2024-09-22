extends State

@export var _tower: Tower
@export var _walk_state: SideViewMammothWalkState
@export var _animation: AnimatedSprite2D
@export var _move_component: MoveComponent


func _ready() -> void:
  _tower.began_ride.connect(_on_tower_began_ride)


func enter() -> void:
  _move_component.velocity = Vector2.ZERO
  _animation.stop()


func _on_tower_began_ride(force: float) -> void:
  _walk_state.acceleration_x = force/1000
  change_state.emit(_walk_state)
