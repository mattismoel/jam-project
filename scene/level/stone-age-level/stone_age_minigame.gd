extends Minigame

@export var duration_secs: float = 10.0

@export_category("References")
@export var projectile: Node2D
@export var mammoth: Node2D
@export var animation_of_mammoth: AnimatedSprite2D

@onready var countdown_label: Label = %CountdownLabel
@onready var force_label: Label = %ForceLabel
@onready var countdown_timer: Timer = %CountdownTimer

var _mammoth_angriness: float = 0

func _ready() -> void:
    countdown_timer.timeout.connect(_on_timeout)
    projectile.target_hit.connect(_on_target_hit)

func _process(delta: float) -> void:
    countdown_label.text = format_time_left()

func _on_timeout() -> void:
    finished.emit(_mammoth_angriness)

func format_time_left() -> String:
    var time_left := countdown_timer.time_left

    var mins := floori(time_left / 60.0)
    var secs := int(time_left) % 60

    return "%02d:%02d" % [mins, secs]

func _on_target_hit() -> void:
    animation_of_mammoth.speed_scale += 0.5
    mammoth.direction*=-1
    mammoth.speed+=10
    
    _mammoth_angriness += 1
    
    if _mammoth_angriness == 1:
        force_label.text = "1 hit"
    else:
        force_label.text = "%d hits" % (_mammoth_angriness)
