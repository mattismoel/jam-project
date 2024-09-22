class_name PauseMenu
extends CanvasLayer

signal continue_pressed
signal settings_pressed

@export var _settings_scene: PackedScene

@onready var _continue_button: Button = %ContinueButton
@onready var _quit_button: Button = %QuitButton


func _ready() -> void:
  _continue_button.pressed.connect(_on_continue_button_pressed)
  _quit_button.pressed.connect(_on_quit_button_pressed)


func _on_continue_button_pressed() -> void:
  continue_pressed.emit()
  pass


func _on_quit_button_pressed() -> void:
  get_tree().quit()
  pass


