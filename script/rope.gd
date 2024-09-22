class_name VerletRope
extends Line2D

@export var _rope_length: float = 30.0
@export var _constrain: float = 1.0
@export var _gravity: Vector2 = Vector2.DOWN * 9.8
@export var _dampening: float = 0.9
@export var _pin_start: bool = true
@export var _pin_end: bool = true

@export var _pin_end_pos: Node2D
@export var _pin_start_pos: Node2D

var _positions: PackedVector2Array = []
var _prev_positions: PackedVector2Array = []
var _point_count


func _ready() -> void:
  _point_count = _calculate_point_count(_rope_length)

  _resize_arrays()
  _initialise_positions()

  if _pin_start && _pin_start_pos:
    set_start(_pin_start_pos.global_position)

  if _pin_end && _pin_end_pos:
    set_start(_pin_start_pos.global_position)



func _process(delta: float) -> void:
  _update_points(delta)
  _update_constrain()

  points = _positions

func _calculate_point_count(distance: float) -> int:
  return int(ceil(distance / _constrain))


func _resize_arrays() -> void:
  _positions.resize(_point_count)
  _prev_positions.resize(_point_count)


func _initialise_positions() -> void:
  for i in range(_point_count):
    var pos :=  global_position + Vector2.RIGHT * (_constrain * i)
    _positions[i] = pos
    _prev_positions[i] = pos


  global_position = Vector2.ZERO


func set_start(pos: Vector2) -> void:
  _positions[0] = pos
  _prev_positions[0] = pos


func set_end(pos: Vector2) -> void:
  _positions[_point_count - 1] = pos
  _prev_positions[_point_count - 1] = pos


func _update_points(delta: float) -> void:
  for i in range(_point_count):
    if i == 0 || i == _point_count - 1:
      continue

    if i == 0 && _pin_start:
      continue

    if i == _point_count - 1 && _pin_end:
      continue

    var velocity := (_positions[i] - _prev_positions[i]) * _dampening
    _prev_positions[i] = _positions[i]
    _positions[i] += velocity + (_gravity * delta)


func _update_constrain() -> void:
  for i in range(_point_count):
    if i == _point_count - 1:
      return

    var distance := _positions[i].distance_to(_positions[i + 1])
    var diff := _constrain - distance
    var pct := diff / distance
    var v := _positions[i + 1] - _positions[i]

    if i == 0 && _pin_start:
      _positions[i + 1] += v * pct

    elif i == 0 && !_pin_start:
      _positions[i] -= v * (pct / 2.0)
      _positions[i + 1] += v * (pct / 2.0)


    elif i != _point_count - 1:
      if i + 1 == _point_count - 1 && _pin_end:
        _positions[i] -= v * pct
      else:
        _positions[i] -= v * (pct / 2.0)
        _positions[i + 1] += v * (pct / 2.0)


func start_pos() -> Vector2:
  return _positions[0]


func end_pos() -> Vector2:
  return _positions[_point_count - 1]
