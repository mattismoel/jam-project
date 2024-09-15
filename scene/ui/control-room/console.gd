class_name Console
extends Control

signal lever_pulled

@export var lever: Lever

func _ready() -> void:
  lever.release.connect(_on_lever_released)


func _on_lever_released() -> void:
  lever_pulled.emit()
  pass
