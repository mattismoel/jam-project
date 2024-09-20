extends Gondola

@export var max_height_duration: float = 0.8


func _ready() -> void:
  seats_occupied = 40


func begin_ride(force: float) -> void:
  super(force)

  var start_pos := position
  var tween := create_tween()

  reached_height = tower.tower_stat.desired_height + randf_range(-10, 10)

  tween.tween_property(self, "position:y", -reached_height, max_height_duration)
  tween.tween_property(self, "position:y", start_pos.y, max_height_duration)

  tween.tween_callback(_on_ride_finish)


func _on_ride_finish() -> void:
  super()
  print("finished test ride")
  pass
