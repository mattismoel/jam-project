class_name Shapes


## Returns the extents of the shape.
static func extents(shape: CollisionShape2D) -> Vector2:
  if shape is RectangleShape2D: return _calculate_rect_extents(_shape)
  if shape is CircleShape2D: return shape.radius

  push_error("Invalid shape. Must be CircleShape2D or RectangleShape2D")
  return Vector2.ZERO


func _calculate_rect_extents(shape: RectangleShape2D) -> Vector2:
  return Vector2(shape.size.x / 2.0, shape.size.y / 2.0)


## Checks whether or not a node is contained within this container.
func contains(shape: CircleShape2D, node: Node2D) -> bool:
  if _shape is CircleShape2D: return _contained_in_circle(_shape, node)
  if _shape is RectangleShape2D: return _contained_in_rect(_shape, node)

  push_error("Invalid shape. Must be RectangleShape2D or CircleShape2D")
  return false


func _contained_in_circle(circle_shape: CircleShape2D, node: Node2D) -> bool:
  return global_position.distance_to(node.global_position) <= circle_shape.radius


func _contained_in_rect(rect_shape: RectangleShape2D, node: Node2D) -> bool:
  var contained_x := node.global_position.x > global_position.x - extents().x\
                  && node.global_position.y < global_position.x + extents().x

  var contained_y := node.global_position.y > global_position.y - extents().y\
                  && node.global_position.y < global_position.y + extents().y

  return contained_x && contained_y


func random_point_in_container() -> Vector2:
  if _shape is CircleShape2D: return _random_point_in_circle(_shape)
  if _shape is RectangleShape2D: return _random_point_in_rect(_shape)

  return Vector2.ZERO


func _random_point_in_circle(circle_shape: CircleShape2D) -> Vector2:
  var rand_length := randf_range(0.0, circle_shape.radius)
  var rand_angle := randf_range(0.0, 2 * PI)
  return global_position + Vector2.RIGHT.rotated(rand_angle) * rand_length


func _random_point_in_rect(rect_shape: RectangleShape2D) -> Vector2:
  return Vector2(
    randf_range(global_position.x - extents().x, global_position.x + extents().x),
    randf_range(global_position.y - extents().y, global_position.y + extents().y)
  )


func rect() -> Rect2:
  if !_shape is RectangleShape2D:
    push_error("Tried to get rect, but shape is not RectangleShape2D")
    return Rect2()

  return Rect2(global_position, _shape.size)


func clamped_pos(node_pos: Vector2) -> Vector2:
  if _shape is RectangleShape2D:
    return Vector2(
      clamp(node_pos.x, global_position.x - extents().x, global_position.x + extents().x),
      clamp(node_pos.y, global_position.y - extents().x, global_position.y + extents().y)
    )

  if _shape is CircleShape2D:
    var dir  := global_position.direction_to(node_pos)
    var dist: float = min(_shape.radius, global_position.distance_to(node_pos))

    return global_position + dir * dist

  return Vector2.ZERO
