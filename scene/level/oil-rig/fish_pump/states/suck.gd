extends State

@export var _fish_pump: FishPump

@export var _suction_force: float = 400.0
@export var _end_area: Area2D
@export var _no_suck_state: State

var _mouse_pos: Vector2

func _ready() -> void:
  _end_area.area_entered.connect(_on_enter_end_area)


func input(event: InputEvent) -> void:
  super(event)
  if event.is_action_released("suck"):
    change_state.emit(_no_suck_state)
  pass


func process(delta):
  super(delta)
  _mouse_pos = get_global_mouse_position()

  for fish in _fish_pump.affected_fish:
    if !is_instance_valid(fish):
      continue

    var dir := fish.global_position.direction_to(_mouse_pos).normalized()

    fish.move_component.velocity += dir * _suction_force * delta
  pass



func _on_enter_end_area(node: Node2D) -> void:
  if !active:
    return

  if node is not Fish:
    return

  node.queue_free()
  _fish_pump.sucked_fish.emit()
  pass
