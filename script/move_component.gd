class_name MoveComponent
extends Node2D

@export var actor: Node2D
@export var _draw_velocity: bool = false

var velocity: Vector2

func _physics_process(delta: float) -> void:
  actor.translate(velocity * delta)

  if _draw_velocity:
    queue_redraw()


func _draw() -> void:
  draw_line(global_position - actor.global_position, global_position - actor.global_position + velocity, Color.RED, 1.0)
