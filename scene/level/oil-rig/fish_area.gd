@tool
class_name FishArea
extends Area2D

const COLOR: Color = Color(Color.BLUE.r, Color.BLUE.g, Color.BLUE.b, 0.2)
const WIDTH: float = 10.0

@export var _shape: RectangleShape2D:
  set(_v):
    _shape = _v

    if !_shape:
      return

    if !_shape.changed.is_connected(queue_redraw):
      _shape.changed.connect(queue_redraw)

    if !_shape.changed.is_connected(_update_boundaries):
      _shape.changed.connect(_update_boundaries)

    queue_redraw()
    _update_boundaries()


@export var _fish_scenes: Array[PackedScene] = []
@export var _initial_count: int = 200
@export var _margin: Vector2i = Vector2(20, 20)

var _fishes: Array[Fish] = []


func _ready() -> void:
  if Engine.is_editor_hint():
    return
  _spawn_all()


func _spawn_all() -> void:
  for i in range(_initial_count):
    var fish_scene: PackedScene = _fish_scenes.pick_random()
    var pos := _random_pos_in_area()

    _spawn(fish_scene, pos)


func _spawn(fish_scene: PackedScene, pos: Vector2) -> void:
  var fish: Fish = fish_scene.instantiate()
  add_child(fish)
  _fishes.append(fish)

  fish.global_position = pos


func _random_pos_in_area() -> Vector2:
  return Vector2(
    randf_range(global_position.x - _shape.size.x / 2.0 + _margin.x, global_position.x + _shape.size.x / 2.0 - _margin.x),
    randf_range(global_position.y - _shape.size.y / 2.0 + _margin.y, global_position.y + _shape.size.y / 2.0 - _margin.y)
  )


func _draw() -> void:
  if !Engine.is_editor_hint():
    return

  _shape.draw(get_canvas_item(), COLOR)


func _update_boundaries() -> void:
  for child in get_children():
    if child is Area2D:
      child.queue_free()

  var left_rect := Rect2(
    global_position.x - _shape.size.x / 2.0 - WIDTH / 2.0,
    global_position.y,
    WIDTH,
    _shape.size.y
  )

  var right_rect := Rect2(
    global_position.x + _shape.size.x / 2.0 + WIDTH / 2.0,
    global_position.y,
    WIDTH,
    _shape.size.y

  )

  var top_rect := Rect2(
    global_position.x,
    global_position.y - _shape.size.y / 2.0 - WIDTH / 2.0,
    _shape.size.x,
    WIDTH
  )

  var bottom_rect := Rect2(
    global_position.x,
    global_position.y + _shape.size.y / 2.0 + WIDTH / 2.0,
    _shape.size.x,
    WIDTH,
  )

  _create_boundary(left_rect)
  _create_boundary(right_rect)
  _create_boundary(top_rect)
  _create_boundary(bottom_rect)


func _create_boundary(at_rect: Rect2) -> void:
  var area := Area2D.new()
  var collision_shape := CollisionShape2D.new()

  var rect_shape := RectangleShape2D.new()
  rect_shape.size = at_rect.size

  add_child(area)
  area.add_child(collision_shape)

  area.global_position = at_rect.position


  area.area_entered.connect(_on_fish_enter_boundary)
  collision_shape.shape = rect_shape


func _on_fish_enter_boundary(node: Node2D) -> void:
  if node is not Fish:
    return

  node.flip()

