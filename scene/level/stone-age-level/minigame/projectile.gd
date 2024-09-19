extends Node2D

@export var velocity_multiplier = 10
@export var collision_area: Area2D

var direction = Vector2.ZERO
var velocity = 0

signal target_hit

func _ready() -> void:
    collision_area.area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
    position+=direction*velocity*delta
    if !get_viewport_rect().has_point(global_position):
        reload()

func _on_area_entered(area: Area2D) -> void:
    if area.name == "Head":
        target_hit.emit()
        reload()

func fire(slingshot_direction: Vector2, slingshot_velocity: float) -> void:
    direction = -slingshot_direction
    velocity = velocity_multiplier*slingshot_velocity

func reload() -> void:
    velocity = 0
    direction = Vector2.ZERO    
    
    var tween = get_tree().create_tween()
    tween.tween_property(self, "position", Vector2.ZERO, 0.1)
