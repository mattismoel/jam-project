extends Node2D

@export var speed: float = 10
var direction: Vector2

func _ready() -> void:
    direction = Vector2.LEFT

func _physics_process(delta: float) -> void:
    if !get_viewport_rect().has_point(global_position):
        direction*=-1
    position += direction*speed*delta
