extends Tower

@export var passenger_mass: float = 50
@export var wait_after_finished: float = 3

@export_category("References")
@export var mammoth: Node2D
@export var rope: Line2D

func _ready() -> void:
    super()
    gondola.occupy_seats(2)
    gondola.top_reached.connect(_on_top_reached)

func calculate_popularity_score(passenger_count: int, height: float) -> float:
    return height / tower_stat.desired_height

func begin_ride(_force: float) -> void:
    var gondola_mass = gondola.seats_occupied * passenger_mass
    var gondola_acceleration = _force/gondola_mass
    
    gondola.begin_ride(gondola_acceleration)
    mammoth.begin_pull(gondola_acceleration)

    began_ride.emit()
    
func _on_top_reached() -> void:
    mammoth.stop_pull()
    gondola.end_ride(wait_after_finished)
