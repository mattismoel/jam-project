@tool
class_name Heart
extends TextureRect

@export var _depleted_texture: Texture2D
@export var _filled_texture: Texture2D
@export var _animation_player: AnimationPlayer

@export var depleted: bool = false:
  set(_v):
    depleted = _v
    _set_texture()
    _set_animation()



func _set_texture() -> void:
  if depleted:
    texture = _depleted_texture
    return

  texture = _filled_texture


func _set_animation() -> void:
  if !depleted:
    _animation_player.pause()

  _animation_player.play("blink")
