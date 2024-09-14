extends Tower

@onready var collision_shape: CollisionShape2D = %TowerCollisionShape

func _ready() -> void:
  tower_stat.changed.connect(func():
    if collision_shape.shape is not RectangleShape2D:
      return

    collision_shape.shape.size = Vector2(collision_shape.shape.size.x, tower_stat.height)
  )


func calculate_popularity_score(passenger_count: int, height: float) -> float:
  return randf()
