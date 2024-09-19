extends Minigame


@onready var button: Button = %Button

var _click_count: int = 0

func _ready() -> void:
  super()
  button.pressed.connect(_on_button_clicked)


func _on_button_clicked() -> void:
  _click_count += 1
  force_buildup = _click_count * 10e2
  pass


func _on_game_timer_timeout() -> void:
  finished.emit(_click_count * 1000)
  pass
