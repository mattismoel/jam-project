extends Node2D

@export var _pause_menu: PauseMenu
@export var _settings: SettingsMenu


func _ready() -> void:
  _pause_menu.continue_pressed.connect(_unpause)
  _pause_menu.settings_pressed.connect(_show_settings)
  _settings.back_button_pressed.connect(_close_settings)


func _input(event: InputEvent) -> void:
  if event.is_action_pressed("pause"):
    if !_pause_menu.visible:
      _pause()
    else:
      _unpause()


func _pause():
  _pause_menu.show()
  get_tree().paused = true
  pass


func _unpause():
  _pause_menu.hide()
  get_tree().paused = false


func _show_settings() -> void:
  _settings.show()
  pass


func _close_settings() -> void:
  _settings.hide()
