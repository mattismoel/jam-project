extends Tower

@export var mammoth: AnimatedSprite2D
@export var rope: Line2D

var mammoth_speed: float = 0

func calculate_popularity_score(passenger_count: int, height: float) -> float:
    return height / tower_stat.desired_height

func begin_ride(_force: float) -> void:
    force = _force
    gondola.begin_ride(_force)
    mammoth_pull(_force)
    
    began_ride.emit()

func _process(delta: float) -> void:
    mammoth.position.x+=mammoth_speed*delta
    rope.set_point_position(3, Vector2(mammoth.position.x, rope.get_point_position(3).y))
    #rope.set_point_position(0, Vector2(rope.get_point_position(3).x, gondola.position.y))

func mammoth_pull(force: float) -> void:
    mammoth.speed_scale = 1+force/20
    mammoth.play()
    
    mammoth_speed = force*2
    
func _draw() -> void:
    pass
