class_name Level
extends Node2D

@export var title: String = "Level"

@export var _next_level: PackedScene
@export var _blueprint_scene: PackedScene
@export var _minigame_scene: PackedScene
@export var _tower: Tower
@export var _console: Console


func _ready() -> void:
  _console.lever_pulled.connect(_on_lever_pull)


func _on_lever_pull() -> void:
  _load_blueprint()
  pass


func _load_blueprint() -> void:
  var blueprint: TutorialBlueprint = _blueprint_scene.instantiate()
  add_child(blueprint)

  blueprint.continue_pressed.connect(_on_blueprint_continue.bind(blueprint))


## Handles logic for when the 'continue' button is pressed within a blueprint.
func _on_blueprint_continue(blueprint: TutorialBlueprint) -> void:
  # Remove the completed blueprint node from the scene tree, as it is no
  # loger needed..
  blueprint.queue_free()

  # Create minigame instance, and add it to the scene tree.
  var minigame: Minigame = _minigame_scene.instantiate()
  add_child(minigame)

  minigame.finished.connect(func(resulting_force: float):
    _on_minigame_finished(resulting_force, minigame)
  )


func _on_minigame_finished(resulting_force: float, minigame: Minigame) -> void:
  minigame.queue_free()
  _tower.begin_ride(resulting_force)
  _tower.finished.connect(_on_tower_ride_finished)
  pass


func _on_tower_ride_finished(popularity_score: float) -> void:
  if !_next_level:
    return

  get_tree().change_scene_to_packed(_next_level)
  pass
