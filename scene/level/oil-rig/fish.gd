class_name Fish
extends Area2D

@export var _move_speed: float = 20.0
@export var move_component: MoveComponent

@export var _raycast: RayCast2D

@onready var _animated_sprite: AnimatedSprite2D = %FishSprite
@onready var _direction: int = 1

func _ready() -> void:
  if randf() > 0.5:
    flip()


func _process(delta: float) -> void:
  move_component.velocity.y = move_toward(move_component.velocity.y, 0.0, 0.5)
  move_component.velocity.x = _direction * _move_speed


func flip() -> void:
  _direction *= -1
  # move_component.velocity *= -1
  _animated_sprite.flip_h = !_animated_sprite.flip_h
