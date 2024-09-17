@tool
class_name FishPump
extends Node2D

signal suck
signal stop_suck

@export var _pin: Node2D
@export var _rope: VerletRope

@export var _suction_size: float = 20.0:
  set(_v):
    if !_suction_collision:
      return

    if !_suction_collision.shape is CircleShape2D:
      push_error("Suction shape is not CircleShape2D!")
      return

    _suction_size = _v
    _suction_collision.shape.radius = _v


@onready var _suction_area: Area2D = %SuctionArea
@onready var _suction_collision: CollisionShape2D = %SuctionCollision
@onready var _pipe_end: CharacterBody2D = %PipeEnd

func _ready() -> void:
  if Engine.is_editor_hint():
    return

  _rope.set_start(_pin.position)


func _process(delta: float) -> void:
  if Engine.is_editor_hint():
    return

  var end_pos := get_local_mouse_position()

  _rope.set_end(end_pos)
  _suction_area.position = end_pos


func _input(event: InputEvent) -> void:
  if Engine.is_editor_hint():
    return

  if event.is_action_pressed("suck"):
    _begin_suck()

  if event.is_action_released("suck"):
    _stop_suck()


func _begin_suck() -> void:
  suck.emit()
  pass


func _stop_suck() -> void:
  stop_suck.emit()
  pass
