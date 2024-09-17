@tool
extends Tower

@export var hang_time: float = 5.0


func _ready() -> void:
  gondola.begin_ride(1000)
  pass


