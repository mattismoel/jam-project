extends Node2D

@export var speed: float = 10
@export var _audio_player: AudioStreamPlayer2D
@export var _animation: AnimatedSprite2D

var direction: Vector2

func _ready() -> void:
    direction = Vector2.RIGHT
    _animation.frame_changed.connect(func():
      var frame_count := _animation.frame

      if frame_count == 0 || frame_count == 2:
        _audio_player.play()
        _audio_player.pitch_scale = 1.0 + randf_range(-0.1, 0.1)
    )


func _physics_process(delta: float) -> void:
    if !get_viewport_rect().has_point(global_position):
        direction*=-1
    position += direction*speed*delta
