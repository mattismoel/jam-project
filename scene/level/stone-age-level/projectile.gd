extends Sprite2D

func fire(direction: Vector2) -> void:
    var corrected_direction = Vector2(-direction.x, direction.y)
    print(corrected_direction)
