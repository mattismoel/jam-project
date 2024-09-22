class_name Rubber
extends AnimatedSprite2D

signal squished
signal unsquished

@export var unsquished_height: int
@export var squished_height: int

@export var _squish_animation_name: String = "squish"


func squish() -> void:
  play(_squish_animation_name)
  await animation_finished
  squished.emit()


func unsquish() -> void:
  play_backwards(_squish_animation_name)
  await animation_finished
  unsquished.emit()
