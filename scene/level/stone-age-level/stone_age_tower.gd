@tool
extends Tower

func begin_ride(_force: float) -> void:
    var acceleration = _force / gondola.mass_kg
    began_ride.emit(acceleration)
