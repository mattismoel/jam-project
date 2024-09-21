extends Level

@export var _fish_pump: FishPump
@export var _camera: Camera2D
@export var _fish_area: FishArea
@export var _minigame: Minigame

var _init_camera_pos: Vector2

func _ready() -> void:
  super()
  _minigame.finished.connect(func(res_force: float):
    _on_minigame_finished(res_force, _minigame)
  )


func _on_lever_pull() -> void:
  _init_camera_pos = _camera.global_position
  _move_camera_to_depth()
  return


func _move_camera_to_depth() -> void:
  var tween := create_tween()
  tween.tween_property(_camera, "global_position:y",  _fish_area.global_position.y, 1.0)
  _fish_pump.allow_movement()

  await tween.finished

  _load_blueprint()


func _move_to_initial_pos() -> void:
  var tween := create_tween()
  tween.tween_property(_camera, "global_position:y", _init_camera_pos.y, 2.0)
  await tween.finished


## Handles logic for when the 'continue' button is pressed within a blueprint.
func _on_blueprint_continue() -> void:
  _blueprint.hide()
  blueprint_continued.emit()

  _minigame.start()
  _fish_pump.allow_suction()

  minigame_started.emit()

  _minigame.finished.connect(func(resulting_force: float):
    _on_minigame_finished(resulting_force, _minigame)
  )



func _on_minigame_finished(resulting_force: float, minigame: Minigame) -> void:
  await _move_to_initial_pos()
  print("moved to init pos")
  _begin_tower_ride(resulting_force)
