extends Gondola

@export var _hang_time: float = 6.0

@onready var _rubber_top: Rubber = %RubberTop
@onready var _rubber_bottom: Rubber = %RubberBottom


func begin_ride(force: float) -> void:
  super(force)

  var begin_pos_y := position.y
  var end_pos := -tower.tower_stat.desired_height + _rubber_top.squished_height
  print(end_pos)

  var up_tween := create_tween()
  up_tween.tween_property(self, "position:y", end_pos, 6.0)
  await up_tween.finished

  top_reached.emit()

  _rubber_top.squish()
  await _rubber_top.squished
  await get_tree().create_timer(_hang_time).timeout
  _rubber_top.unsquish()

  var down_tween := create_tween()
  down_tween.tween_property(self, "position:y", begin_pos_y, 0.9)
  pass
