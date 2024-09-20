@tool
extends Tower

@export var _passenger_mass: float = 50
@export_category("References")

func _ready() -> void:
  super()

  if Engine.is_editor_hint():
      return

  gondola.occupy_seats(2)

func begin_ride(_force: float) -> void:
    var gondola_mass = gondola.seats_occupied * _passenger_mass
    var gondola_acceleration = _force/gondola_mass

    began_ride.emit(gondola_acceleration)
