class_name SideViewMammothWalkState
extends State

@export var _gondola: Gondola
@export var _idle_state: State
@export var _move_component: MoveComponent
@export var _animation: AnimatedSprite2D
@export var _animation_speed_up_rate: float = 10e6
@export var _audio_player: AudioStreamPlayer2D


var acceleration_x: float = 0.0
var _speed: float = 0.0


func _ready() -> void:
  _gondola.top_reached.connect(_on_gondola_top_reached)
  _animation.frame_changed.connect(_audio_player.play)


func enter() -> void:
  _animation.play()


func physics_process(_delta: float) -> void:
    _move_component.velocity.x += acceleration_x
    _animation.speed_scale += _speed / _animation_speed_up_rate

func _on_gondola_top_reached() -> void:
  change_state.emit(_idle_state)
