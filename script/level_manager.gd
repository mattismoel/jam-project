@tool
extends Node


signal changed_level(idx: int)
signal last_level_completed

var _curr_level: Node

@export var _bypass: bool = false


## The levels of this LevelMangager instance.
@export var _levels: Array[LevelEntry] = []
## Optional. The index of the first level. If set to a zero or positive integer
## value, the LevelManager starts at this index, else, it starts at the
## first level of the 'levels' array (idx = 0).
@export var _first_level_idx_overwrite: int = -1:
  set(_v):
    _v = clampi(_v, -1, level_count() - 1)

    _first_level_idx_overwrite = _v


@export var _level_presentation_duration: float = 1.0
@export var _presentation_scene: PackedScene

## The current level index.
@onready var _curr_level_idx: int = _first_level_idx_overwrite if _first_level_idx_overwrite >= 0 else 0


func _ready() -> void:
  if Engine.is_editor_hint() || _bypass:
    return
  pass


func begin() -> void:
  _change_level(_curr_level_idx)


## Proceeds to the next level.
func next_level() -> void:
  var last_idx := level_count() - 1
  var next_idx := mini(_curr_level_idx + 1, last_idx)

  if next_idx > last_idx:
    last_level_completed.emit()
    return

  _change_level(next_idx)
  pass


## Returns the amount of levels of the LevelManager.
func level_count() -> int:
  return _levels.size()


## Returns the non-zero-indexed count of the current level. I.e. if current
## level index is 2, the returned value is 3 as in 'Level 3'.
func current_level_count() -> int:
  return _curr_level_idx + 1


## Returns the current LevelEntry.
func curr_level() -> LevelEntry:
  return _levels[_curr_level_idx]


func _change_level(idx: int) -> void:
  _curr_level_idx = idx

  var _presentation: LevelPresentation = _presentation_scene.instantiate()

  get_tree().root.add_child.call_deferred(_presentation)
  await _presentation.fade_in()

  if _curr_level:
    _curr_level.queue_free()

  var level := _levels[idx].level_scene.instantiate()
  get_tree().root.add_child.call_deferred(level)

  await get_tree().create_timer(_level_presentation_duration).timeout


  await _presentation.fade_out()
  _presentation.queue_free()

  _curr_level = level


  # get_tree().change_scene_to_packed.call_deferred(_levels[idx].level_scene)
  changed_level.emit(_curr_level_idx)
  pass
