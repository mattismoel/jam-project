extends Gondola

var _acceleration: float = 0
var _speed: float = 0


func _physics_process(delta: float) -> void:
    if _acceleration != 0:
        _speed+=_acceleration*delta
        var delta_pos=_speed*delta

        position+=delta_pos*Vector2.UP
        reached_height+=delta_pos

        if reached_height>tower.tower_stat.height:
            _on_ride_finish()


func begin_ride(acceleration: float) -> void:
    _acceleration = acceleration
    print("Gondola going up with acceleration %f" % _acceleration)

func _on_ride_finish() -> void:
    _acceleration = 0
    _speed = 0
    super()
