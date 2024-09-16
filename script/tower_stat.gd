@tool
class_name TowerStat
extends Resource

@export_range(0.0, 1000) var height: int = 100:
  set(_h):
    height = _h
    emit_changed()


@export_range(0.0, 1000) var desired_height: int = 100:
  set(_h):
    desired_height = min(height, _h)
    emit_changed()
