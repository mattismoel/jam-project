class_name Minigame
extends Node

signal force_changed(force: float)
signal finished(force: float)
signal started

@export var _duration: float = 10.0
@export var _game_timer: Timer
@export var _auto_start: bool = true
@export var _minigame_ui: MinigameUI


var force_buildup: float = 0.0:
  set(_v):
    force_buildup = _v
    force_changed.emit(force_buildup)


func _ready() -> void:
  _game_timer.autostart = false
  _game_timer.wait_time = _duration
  _game_timer.one_shot = true
  _game_timer.timeout.connect(_on_game_timer_timeout)

  if _auto_start:
    start()


func _process(delta: float) -> void:
  _minigame_ui.set_time_left(_game_timer.time_left)


func start() -> void:
  print("start_minigame")
  _game_timer.start()
  started.emit()


func _on_game_timer_timeout() -> void:
  finished.emit(force_buildup)
  pass
