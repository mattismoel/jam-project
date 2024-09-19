extends Gondola

@export var gravity: float

func _process(delta: float) -> void:
    pass

func begin_ride(force: float) -> void:
    print("Gondola going up...")
