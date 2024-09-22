extends CanvasLayer

const FADE_DURATION: float = 4.0


@export var _ui_root: Control
@export var _play_button: Button
@export var _game_scene: PackedScene
@export var _background_audio_player: BackgroundAudioPlayer


func _ready() -> void:
  _play_button.pressed.connect(_on_play_button_pressed)


func _on_play_button_pressed() -> void:
  await _fade_out()

  var game := _game_scene.instantiate()
  get_tree().root.add_child(game)

  LevelManager.begin()
  # get_tree().change_scene_to_packed(_game_scene)
  pass


func _fade_out() -> void:
  var tween := create_tween()
  _background_audio_player.stop()
  tween.tween_property(_ui_root, "modulate", Color.BLACK, FADE_DURATION)
  await tween.finished
  queue_free()
  pass
