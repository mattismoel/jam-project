class_name ContainWithinComponent
extends Node

@export var container: ContainerComponent

@export var _actor: Node2D
@export var _physics: bool = false

func _physics_process(delta: float) -> void:
  if !_physics:
    return

  _actor.global_position = container.clamped_pos(_actor.global_position)


func _process(delta: float) -> void:
  if _physics:
    return

  _actor.global_position = container.clamped_pos(_actor.global_position)
