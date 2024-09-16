## __________________________________
##
## WORK IN PROGRESS! NOT IMPLEMENTED!
## __________________________________

@tool
class_name LevelManager
extends Node

enum LevelState {
  UNENTERED,
  IN_BLUEPRINT,
  IN_MINIGAME, IN_LAUNCH_SCENE
}

## Emitted when a level has successfully changed to its first stage.
signal level_changed

## Emitted when a level has entered its blueprint tutorial stage.
signal blueprint_entered

## Emitted when a level has entered its minigame stage.
signal minigame_entered

## Emitted when a level has entered its launch stage.
signal launch_entered

## Emitted when a level has finished
signal level_finished


@export var levels: Array[PackedScene] = []

## The optional overwrite of the start level. If set to a value other than -1,
## the level manager will set the start level as the set index.
@export var start_level_idx_overwrite: int = -1:
  set(_v):
    start_level_idx_overwrite = clampi(_v, -1, max_level_idx())

@export_category("Scene Transitions")
@export var _blueprint_scene_transition_scene: PackedScene
@export var _minigame_scene_transition_scene: PackedScene
@export var _launch_scene_transition_scene: PackedScene


## The current level index.
var curr_level_idx: int = \
  0 if start_level_idx_overwrite <= -1 else start_level_idx_overwrite

var curr_level_state: LevelState = LevelState.UNENTERED

func _ready() -> void:
  progress()


## Progresses onto next stage.
## If nescessary, the progress function changes to next level.
func progress() -> void:
  if curr_level_idx == 0 && curr_level_state == LevelState.UNENTERED:
    _load_tutorial(0)
    pass

  var should_proceed_to_next_level := \
    curr_level_state == LevelState.IN_LAUNCH_SCENE

  var next_idx := curr_level_idx if !should_proceed_to_next_level else curr_level_idx + 1


  match curr_level_state:
    LevelState.IN_BLUEPRINT:
      _load_minigame(next_idx)
      pass
    LevelState.IN_MINIGAME:
      pass
    LevelState.IN_LAUNCH_SCENE:
      pass


func _load_tutorial(level_idx: int) -> void:
  curr_level_state = LevelState.IN_BLUEPRINT
  pass


func _load_minigame(level_idx: int) -> void:
  curr_level_state = LevelState.IN_MINIGAME
  pass


func _load_launch_scene(level_idx: int) -> void:
  curr_level_state = LevelState.IN_LAUNCH_SCENE
  pass


## Converts a level index to a level count, i.e. idx = 0 -> 1.
func idx_to_count(idx: int) -> int:
  return idx + 1


## Returns the maximum index a level can have, with respect to the level count.
func max_level_idx() -> int:
  return level_count() - 1


## Returns the level count.
func level_count() -> int:
  return len(levels)
