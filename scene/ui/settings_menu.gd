class_name SettingsMenu
extends CanvasLayer

signal back_button_pressed

@export var _pause_menu_scene: PackedScene

@onready var _music_volume_slider: HSlider = %MusicVolumeSlider
@onready var _sfx_volume_slider: HSlider = %SFXVolumeSlider
@onready var _music_volume_label: Label = %MusicVolumeLabel
@onready var _sfx_volume_label: Label = %SFXVolumeLabel
@onready var _back_button: Button = %BackButton


func _ready() -> void:
  _music_volume_slider.value_changed.connect(_on_music_volume_change)
  _sfx_volume_slider.value_changed.connect(_on_sfx_volume_change)

  _music_volume_label.text = _format_pct(_music_volume_slider.value)
  _sfx_volume_label.text = _format_pct(_sfx_volume_slider.value)

  _back_button.pressed.connect(_on_back_button_pressed)


func _on_music_volume_change(value: float) -> void:
  print("NOT IMPLEMENTED: change music volume to %.02f" % value)
  push_warning("change music volume not implemented yet...")
  _music_volume_label.text = _format_pct(value)
  pass


func _on_sfx_volume_change(value: float) -> void:
  print("change sfx volume to %.02f" % value)
  push_warning("change sfx volume not implemented yet...")
  _sfx_volume_label.text = _format_pct(value)
  pass



func _format_pct(val: float) -> String:
  return "%d %%" % roundi(val * 100)


func _on_back_button_pressed() -> void:
  back_button_pressed.emit()
