extends Tower

@export var passenger_mass: float = 50

@export_category("References")
@export var mammoth: AnimatedSprite2D
@export var rope: Line2D

var gondola_acceleration: float = 0
var gondola_speed: float = 0

func _ready() -> void:
    super()
    gondola.occupy_seats(2)

func calculate_popularity_score(passenger_count: int, height: float) -> float:
    return height / tower_stat.desired_height

func begin_ride(_force: float) -> void:
    var gondola_mass = gondola.seats_occupied * passenger_mass
    gondola_acceleration = _force/gondola_mass
    print("Ride begun with gondola_acceleration %f" % gondola_acceleration)
    
    gondola.begin_ride(gondola_acceleration)
    mammoth.play()
    
    began_ride.emit()

func _physics_process(delta: float) -> void:
    gondola_speed+=gondola_acceleration*delta
    
    mammoth.position.x+=gondola_speed*delta
    mammoth.speed_scale+=gondola_speed/10e6
    
func _process(delta: float) -> void:
    var correction = Vector2(-3, 108) #rope.position-rope.get_point_position(0)
    rope.set_point_position(0, correction+gondola.position)
    rope.set_point_position(3, Vector2(mammoth.position.x, rope.get_point_position(3).y))

func _on_gondola_ride_finished(height: float, seats_occupied: int) -> void:
    super(height, seats_occupied)
    gondola_acceleration = 0
    gondola_speed = 0
