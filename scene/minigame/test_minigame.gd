extends Minigame

@export var desired_click_count: int = 10

var _click_count: int = 0


func _unhandled_input(event: InputEvent) -> void:
  if !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
    return

  _click_count += 1

  if _click_count == desired_click_count:
    print(_click_count)
    finished.emit(randf() * 1000)

