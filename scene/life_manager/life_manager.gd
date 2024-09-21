extends Node

signal full_lives
signal out_of_lives
signal lives_changed

@export var max_life_count: int = 3

var current_lives: int = max_life_count - 1


## Deplenishes the current live count by one.
func take_life() -> void:
  _modify_lives_by(-1)
  pass


## Deplenishes the given amount of lives from the current life count.
func take_lives(count: int) -> void:
  _modify_lives_by(-count)
  pass


## Adds one live to the current live count.
func add_life() -> void:
  _modify_lives_by(1)
  pass


## Adds the given amount of lives to the current life count.
func add_lives(count: int) -> void:
  _modify_lives_by(count)
  pass


func _modify_lives_by(x: int) -> void:
  current_lives += x
  current_lives = clampi(current_lives, 0, max_life_count)

  if current_lives <= 0:
    out_of_lives.emit()

  if current_lives >= max_life_count:
    full_lives.emit()

  lives_changed.emit(x)
  pass
