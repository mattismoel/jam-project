@tool
class_name WaterBody
extends Node2D

@export var _dimensions: Vector2:
  set(_v):
    _dimensions = _v
    _initialise()

@export var _resolution: int = 10:
  set(_v):
    _resolution = _v
    _initialise()


@export var _spring_scene: PackedScene
@export var _spring_constant = 0.015
@export var _dampening = 0.03
@export var _spread: float = 0.0002
@export var _pass_count: int = 8

@export var _border_thickness: float = 2.0
@export var _smooth: bool = true

@onready var _body_polygon: Polygon2D = %BodyPolygon
@onready var _border: SmoothPath = %WaterBorder

@export var _mouse_motion: bool = false
var _mouse_in_water: bool = false

var _bottom: float = 0.0
var _target_height = global_position.y
var _springs: Array[WaterSpring] = []

func _ready() -> void:
  _initialise()


func _initialise() -> void:
  if not _border:
    return

  # Clean up previous springs
  _springs = []
  for child in get_children():
    if child is WaterSpring:
      child.free()

  _border.width = _border_thickness
  _bottom = _target_height + _dimensions.y

  var spring_distance := _dimensions.x / _resolution

  for i in range(_resolution + 1):
    var spring: WaterSpring = _spring_scene.instantiate()
    var x_pos := spring_distance * i

    _springs.append(spring)

    add_child(spring)

    spring.initialise(x_pos, i)

    if i == 0 || i == _resolution:
      var placement = WaterSpring.Placement.LEFT if i == 0 else WaterSpring.Placement.RIGHT
      spring.set_collision_width(spring_distance / 2, placement)
    else:
      spring.set_collision_width(spring_distance)

    spring.splash.connect(splash)


func _physics_process(delta: float) -> void:
  for spring in _springs:
    spring.update_water(_spring_constant, _dampening)

  var left_deltas: PackedFloat32Array = []
  var right_deltas: PackedFloat32Array = []

  for i in range(_springs.size()):
      left_deltas.append(0)
      right_deltas.append(0)


  for i in range(_pass_count):
    for j in range(_springs.size()):
      if j > 0:
        left_deltas[j] = _spread * (_springs[j].height - _springs[j - 1].height)
        _springs[j - 1].velocity_y += left_deltas[j]

      if j < _springs.size() - 1:
        right_deltas[j] = _spread * (_springs[j].height - _springs[j + 1].height)
        _springs[j + 1].velocity_y += right_deltas[j]

  _draw_border(_smooth)
  _draw_water_body()


func _input(event: InputEvent) -> void:
  if !_mouse_motion:
    return

  if !event is InputEventMouseMotion:
    return

  var mouse_pos := get_global_mouse_position()
  if mouse_pos.y >= global_position.y && !_mouse_in_water:
    var idx := _global_pos_x_to_idx(mouse_pos.x)
    var mouse_vel = event.relative

    splash(idx, mouse_vel.y)
    _mouse_in_water = true

  if mouse_pos.y < global_position.y:
    _mouse_in_water = false


func _global_pos_x_to_idx(pos_x: float) -> int:
  var fraction := pos_x / _dimensions.x

  var idx := floori(fraction * _resolution)

  if idx == _resolution:
    return idx - 1

  return idx


func splash(idx: int, speed: float) -> void:
  if idx < 0 or idx > _springs.size() - 1:
    return

  _springs[idx].velocity_y += speed


func _draw_water_body():
  var curve := _border.curve
  var points := curve.get_baked_points()

  var water_polygon_points := points

  var first_idx: int = 0
  var last_idx: int = water_polygon_points.size() - 1

  water_polygon_points.append(Vector2(water_polygon_points[last_idx].x, _bottom))
  water_polygon_points.append(Vector2(water_polygon_points[first_idx].x, _bottom))

  _body_polygon.polygon = water_polygon_points

func _draw_border(smooth: bool = true) -> void:
  var curve := Curve2D.new()

  var surface_points: PackedVector2Array = []

  for i in range(_springs.size()):
    surface_points.append(_springs[i].position)


  for i in range(surface_points.size()):
    curve.add_point(surface_points[i])
    pass

  _border.curve = curve
  _border.smooth = smooth

  _border.queue_redraw()
