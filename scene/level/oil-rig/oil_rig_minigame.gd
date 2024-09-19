extends Minigame

@export var _force_per_fish: float = 10.0
@export var _fish_pump: FishPump


func _ready() -> void:
  super()
  _fish_pump.sucked_fish.connect(_on_sucked_fish)


func _on_sucked_fish() -> void:
  force_buildup += _force_per_fish
