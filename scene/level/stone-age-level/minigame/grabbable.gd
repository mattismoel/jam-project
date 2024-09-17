extends Area2D

signal released
signal grabbed

var _is_hold = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
            _is_hold = true
            grabbed.emit()
        elif event.is_released() and _is_hold:
            _is_hold = false
            released.emit()
