extends Node2D

@export var movable_radius: float
@export var min_fire_radius: float

@export_category("References")
@export var _grabbable_area: Area2D
@export var _string: Line2D
@export var _projectile: Node2D

var start_pos = Vector2.ZERO
var following_mouse: bool = false

func _ready() -> void:
    _grabbable_area.released.connect(_on_released)
    _grabbable_area.grabbed.connect(_on_grabbed)

func _process(delta: float) -> void:
    if following_mouse and _projectile.velocity == 0:
        follow_mouse()

func follow_mouse() -> void:
    var target_pos = get_local_mouse_position()
    _grabbable_area.position = target_pos

    # Limit range of movement for projectile
    var k = movable_radius/target_pos.length()
    if k < 1: target_pos*=k
    _projectile.position = target_pos
    
    # Limit range of movement for string
    var string_target_pos = _string.get_local_mouse_position()
    if k < 1: string_target_pos*=k
    _string.set_point_position(1, string_target_pos)
    
func _on_grabbed() -> void:
    following_mouse = true
    
func _on_released() -> void:
    var strength = _string.points[1].length()
    if strength > min_fire_radius:
        _projectile.fire(_string.points[1].normalized(), _string.points[1].length())
        
        _grabbable_area.position = start_pos
        _string.points[1] = start_pos
        
        following_mouse = false
