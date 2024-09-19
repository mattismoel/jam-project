extends State

@export var _mammoth: Node2D
@export var _animation: AnimatedSprite2D
var _speed: float = 0

func physics_process(delta: float) -> void:
    _speed+=_mammoth.acceleration*delta
    
    _mammoth.position.x+=_speed*delta
    _animation.speed_scale+=_speed/10e6
