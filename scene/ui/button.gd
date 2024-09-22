extends Button

@onready var _player: AudioStreamPlayer = %AudioStreamPlayer

func _ready() -> void:
  pressed.connect(_player.play)
