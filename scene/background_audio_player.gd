class_name BackgroundAudioPlayer
extends Node

@export var _sounds: Array[BackgrondAudio] = []
@export var _fade_in_duration: float = 2.0

var _players: Array[AudioStreamPlayer] = []

func _ready() -> void:
  for sound in _sounds:
    var audio_player  := AudioStreamPlayer.new()

    _players.append(audio_player)

    audio_player.stream = sound.stream
    audio_player.volume_db = linear_to_db(0.00001)

    add_child(audio_player)

    audio_player.play()

    fade_stream(audio_player, sound.volume, _fade_in_duration)


func fade_stream(player: AudioStreamPlayer, to_vol_linear: float, duration: float) -> void:
  if to_vol_linear == 0.0:
    to_vol_linear += 0.001

  var tween := create_tween()
  tween.tween_property(player, "volume_db", linear_to_db(to_vol_linear), duration)
  await tween.finished
  pass


func stop() -> void:
  for child in get_children():
    if child is not AudioStreamPlayer:
      continue

    fade_stream(child, 0.0, _fade_in_duration)
  # for player in _players:
  #     print(player.name)
  #     player.stop()
  #     await fade_stream(player, 0.001, _fade_in_duration)
  #     _players.erase(player)
  #     player.queue_free()
