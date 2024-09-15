class_name Lever
extends TextureRect

## Emitted when the lever itself is released.
signal release


@export var sprite_frames: SpriteFrames

@onready var handle: ScrollBar = %HandleScrollBar
@onready var max_step_count: int = sprite_frames.get_frame_count("default")

## Whether or not the user can release the lever. The user can only release
## the lever, when it is in the final step position.
var _can_release_lever: bool = false


func _ready() -> void:
  handle.value_changed.connect(_on_pull)


func _input(event: InputEvent) -> void:
  # Release the lever when possible, and the user releases the click button.
  if event.is_action_released("click") && _can_release_lever:
    _release_lever()


## Sets the step of the lever. 0 is top, max_step_count is bottom.
## The idx value is automatically clamped within boundaries of the step count.
func set_step(idx: int) -> void:
  idx = clampi(idx, 0, max_step_count - 1)
  set_frame(idx)

  if idx == max_step_count - 1:
    _can_release_lever = true
    return

  _can_release_lever = false


## Sets the frame of the lever to a given index.
##
## The index should be the same as the levers current step.
func set_frame(idx: int) -> void:
  texture = sprite_frames.get_frame_texture("default", idx)


func _on_pull(value: float) -> void:
  var frame_idx = floori(value * (sprite_frames.get_frame_count("default") - 1))
  set_step(frame_idx)


func _release_lever() -> void:
  release.emit()
  pass
