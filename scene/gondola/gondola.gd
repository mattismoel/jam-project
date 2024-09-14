class_name Gondola
extends Node2D

signal fully_occupied
signal seats_changed(occupied: int)
signal finished(reached_height: float, seats_occupied: int)


@export var max_seats: int = 100

@export_category("References")
@export var tower: Tower

var seats_occupied: int = 0
var reached_height: float

func occupy_seats(count: int) -> void:
  seats_occupied += count

  seats_occupied = min(seats_occupied, max_seats)

  if seats_occupied >= max_seats:
    fully_occupied.emit()

  seats_changed.emit(seats_occupied)


func begin_ride(force: float) -> void:
  pass


func _on_ride_finish() -> void:
  finished.emit(reached_height, seats_occupied)
  pass
