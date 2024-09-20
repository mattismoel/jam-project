class_name Console
extends Control

@onready var _lever: Lever = %Lever
@onready var _force_label: Label = %ForceLabel
@onready var _level_label: Label = %LevelLabel


func _ready() -> void:
  _lever.release.connect(_on_lever_released)

  LevelManager.changed_level.connect(_on_level_changed)
  SignalBus.force_changed.connect(_on_force_changed)
  pass


func _on_lever_released() -> void:
  SignalBus.lever_pulled.emit()
  pass


func _on_force_changed(force: float) -> void:
  _force_label.text = _format_force_text(force)
  pass


func _on_level_changed(_level_idx: int) -> void:
  print("change_level")
  _force_label.text = _format_force_text(0.0)

  var total_level_count: int = LevelManager.level_count()
  var curr_level_count: int = LevelManager.current_level_count()

  _level_label.text = _format_level_text(curr_level_count, total_level_count)
  _lever.reset()
  pass


func _format_force_text(force: float) -> String:
  return "%04d N" % force


func _format_level_text(current_level_count: int, total_level_count: int) -> String:
  return "%d of %d" % [current_level_count, total_level_count]
