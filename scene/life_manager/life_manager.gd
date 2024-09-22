extends Node

signal full_lives
signal out_of_lives
signal lives_changed

@export var max_life_count: int = 3
@export var _game_over_screen_scene: PackedScene

var current_lives: int = max_life_count


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


## Returnes whether or not the game is game over (i.e. all lives are depleted).
func is_game_over() -> bool:
  return current_lives <= 0


func _modify_lives_by(x: int) -> void:
  current_lives += x
  current_lives = clampi(current_lives, 0, max_life_count)

  if current_lives <= 0:
    print("out of lives")
    _on_out_of_lives()

  if current_lives >= max_life_count:
    full_lives.emit()

  lives_changed.emit(x)
  pass


func game_over() -> void:
  print("igame over")
  take_lives(3)



func _on_out_of_lives() -> void:
  out_of_lives.emit()
  var game_over_screen := _game_over_screen_scene.instantiate()
  get_tree().root.add_child(game_over_screen)
  pass
