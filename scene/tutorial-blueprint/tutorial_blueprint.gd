class_name TutorialBlueprint
extends CanvasLayer

## Emitted when the user presses the continue button in a blueprint to
## proceed into the minigame.
signal continue_pressed

@onready var _title_label: Label = %TitleLabel
@onready var _level_count_label: Label = %LevelCountLabel
@onready var _continue_button: Button = %ContinueButton


func _ready() -> void:
  _continue_button.pressed.connect(_on_continue)
  pass


## TODO: Implement.
func set_blueprint_data(data: BlueprintData) -> void:
  _title_label.text = data.title
  _level_count_label.text = "%d/%d" % [data.level_count, data.total_level_count]


func _on_continue() -> void:
  continue_pressed.emit()
