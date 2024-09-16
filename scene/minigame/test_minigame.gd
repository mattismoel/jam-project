extends Minigame

@export var duration_secs: float = 10.0

@onready var button: Button = %Button
@onready var countdown_label: Label = %CountdownLabel
@onready var force_label: Label = %ForceLabel
@onready var countdown_timer: Timer = %CountdownTimer

var _click_count: int = 0

var force_buildup: float = 0.0


func _ready() -> void:
  button.pressed.connect(_on_button_clicked)
  countdown_timer.timeout.connect(_on_timeout)


func _process(delta: float) -> void:
  countdown_label.text = format_time_left()
  pass


func _on_button_clicked() -> void:
  _click_count += 1
  force_buildup = _click_count * 10e2

  force_label.text = "%d N" % (force_buildup)


func _on_timeout() -> void:
  finished.emit(_click_count * 1000)


func format_time_left() -> String:
  var time_left := countdown_timer.time_left

  var mins := floori(time_left / 60.0)
  var secs := int(time_left) % 60

  return "%02d:%02d" % [mins, secs]
