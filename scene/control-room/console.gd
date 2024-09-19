class_name Console
extends Control

signal lever_pulled

@export var minigame: Minigame:
  set(_v):
    if _v == null:
      return

    minigame = _v

    if !minigame.force_changed.is_connected(_on_force_changed):
      minigame.force_changed.connect(_on_force_changed)


@onready var _lever: Lever = %Lever
@onready var _force_label: Label = %ForceLabel


func _ready() -> void:
  if minigame:
    minigame.force_changed.connect(_on_force_changed)

  _lever.release.connect(_on_lever_released)


func _on_lever_released() -> void:
  lever_pulled.emit()
  pass


func _on_force_changed(force: float) -> void:
  _force_label.text = "%04d N" % force
  pass
