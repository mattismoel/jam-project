class_name MinigameUI
extends CanvasLayer

@export var _time_left_label: Label

func set_time_left(time_left: float) -> void:
  _time_left_label.text = TimeUtil.format_time_left(time_left)
