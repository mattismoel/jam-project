extends Gondola

@export var _tower: Tower
@export var max_height_duration: float
@export var rope: Line2D

func _ready() -> void:
  _tower.began_ride.connect(_begin_ride)


func _begin_ride(with_force: float) -> void:
  var start_pos := position
  var tween := create_tween()

  var calculated_target = _tower.height*(with_force/_tower.target_force)
  #tower.height + randf_range(-50, 0)
  tween.tween_property(self, "position:y", -calculated_target, max_height_duration)
  top_reached.emit()
  reached_height = calculated_target

  tween.tween_callback(_on_ride_finish)

func _on_ride_finish() -> void:
    super()
    rope.remove_point(3)
