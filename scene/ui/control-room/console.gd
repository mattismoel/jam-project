class_name Console
extends Control

signal lever_pulled

@onready var _lever: Lever = %Lever

func _ready() -> void:
  _lever.release.connect(_on_lever_released)


func _on_lever_released() -> void:
  lever_pulled.emit()
  pass
