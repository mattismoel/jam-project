@tool
class_name WaterSpring
extends Node2D

enum Placement {
  LEFT,
  RIGHT,
  INNER
}

signal splash(idx: int, speed_y: float)

@export var motion_factor = 0.02

@onready var _spring_collision_shape: CollisionShape2D = %SpringCollisionShape
@onready var _spring_detector: Area2D = %SpringDetector

var velocity_y: float = 0.0
var height = 0.0

var _force: float = 0.0
var _target_height = 0.0
var _idx: int = 0
var _collided_with: Node2D

func _ready() -> void:
  _spring_detector.body_entered.connect(_on_enter)

func update_water(spring_constant: float, dampening: float) -> void:
  height = position.y

  var x = height - _target_height
  var loss = -dampening * velocity_y

  _force = -spring_constant * x + loss
  velocity_y += _force

  position.y += velocity_y


func initialise(x_pos: float, idx: int):
  _idx = idx
  _target_height = position.y
  position.x = x_pos
  height = position.y
  velocity_y = 0.0


func set_collision_width(w: float, placement: Placement = Placement.INNER) -> void:
  if !_spring_collision_shape.shape is RectangleShape2D:
    return

  var shape := RectangleShape2D.new()

  var _extends: Vector2 = _spring_collision_shape.shape.size
  var new_extends = Vector2(w, _extends.y)

  shape.size = new_extends
  _spring_collision_shape.shape = shape

  match placement:
    Placement.LEFT:
      _spring_collision_shape.position.x += w / 2.0
      pass
    Placement.RIGHT:
      _spring_collision_shape.position.x -= w / 2.0
      pass

func _on_enter(node: Node2D) -> void:
  if node == _collided_with:
    return

  var speed_y = 0.0

  if node is RigidBody2D:
    speed_y = node.linear_velocity.y * motion_factor

  if node is CharacterBody2D:
    speed_y = node.velocity.y * motion_factor

  splash.emit(_idx, speed_y)
