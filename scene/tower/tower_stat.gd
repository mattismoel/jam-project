@tool
class_name TowerStat
extends Resource

@export_range(0.0, 1000) var height: float = 100.0:
  set(_h):
    height = _h
    emit_changed()


@export_range(0.0, 1000) var desired_height: float = 100.0:
  set(_h):
    height = min(height, _h)
    emit_changed()

