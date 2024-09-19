class_name Level
extends Node2D

signal level_entered
signal blueprint_continued
signal blueprint_entered
signal minigame_started
signal minigame_ended
signal tower_began
signal tower_ended

@export var _blueprint_scene: PackedScene
@export var _minigame_scene: PackedScene
@export var _tower: Tower
@export var _console: Console


func _ready() -> void:
  _console.lever_pulled.connect(_on_lever_pull)
  level_entered.emit()


func _on_lever_pull() -> void:
  _load_blueprint()
  pass


func _load_blueprint() -> void:
  var blueprint: TutorialBlueprint = _blueprint_scene.instantiate()
  add_child(blueprint)

  var level: LevelEntry = LevelManager.curr_level()

  blueprint.set_blueprint_data(level.title, LevelManager.current_level_count())

  blueprint_entered.emit()
  blueprint.continue_pressed.connect(_on_blueprint_continue.bind(blueprint))


## Handles logic for when the 'continue' button is pressed within a blueprint.
func _on_blueprint_continue(blueprint: TutorialBlueprint) -> void:
  # Remove the completed blueprint node from the scene tree, as it is no
  # loger needed..
  blueprint.queue_free()
  blueprint_continued.emit()

  # Create minigame instance, and add it to the scene tree.
  var minigame: Minigame = _minigame_scene.instantiate()
  add_child(minigame)
  _console.minigame = minigame

  minigame_started.emit()

  minigame.finished.connect(func(resulting_force: float):
    _on_minigame_finished(resulting_force, minigame)
  )


func _on_minigame_finished(resulting_force: float, minigame: Minigame) -> void:
  minigame_ended.emit()
  minigame.queue_free()
  _begin_tower_ride(resulting_force)
  pass


func _on_tower_ride_finished(popularity_score: float) -> void:
  print("ayo")
  tower_ended.emit()
  LevelManager.next_level()
  pass


func _begin_tower_ride(resulting_force: float) -> void:
  tower_began.emit()
  _tower.begin_ride(resulting_force)
  _tower.finished.connect(_on_tower_ride_finished)


