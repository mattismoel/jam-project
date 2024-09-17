extends Node2D

@export var _grabbable_area: Area2D
@export var _string: Line2D
@export var _projectile: Sprite2D

var start_pos = Vector2(0,0)
var follow_mouse = false

func _ready() -> void:
    _grabbable_area.released.connect(_on_released)
    _grabbable_area.grabbed.connect(_on_grabbed)

func _process(delta: float) -> void:
    if follow_mouse:
        var mouse_pos = get_global_mouse_position()
        var clamped_pos = Vector2(clamp(mouse_pos.x, 0, get_viewport_rect().size.x), clamp(mouse_pos.y, 0, get_viewport_rect().size.y)) - position
        
        _grabbable_area.position = clamped_pos 
        _string.points[1] = clamped_pos
        _projectile.position = clamped_pos

func _on_grabbed() -> void:
    follow_mouse = true
    
func _on_released() -> void:
    follow_mouse = false
    _grabbable_area.position = start_pos
    _string.points[1] = start_pos
    _projectile.position = start_pos
    
    
