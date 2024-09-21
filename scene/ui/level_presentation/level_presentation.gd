class_name LevelPresentation
extends CanvasLayer

@export var _level_title_label: Label
@export var _description_label: TypedLabel
@export var _lives_container: HBoxContainer
@export var _heart_scene: PackedScene
@export var _animation_player: AnimationPlayer


func _ready() -> void:
  var current_life_count: int = LifeManager.current_lives
  var max_life_count: int = LifeManager.max_life_count

  for i in range(current_life_count):
    var heart: Heart = _heart_scene.instantiate()
    _lives_container.add_child(heart)

  for i in range(max_life_count - current_life_count):
    var heart: Heart = _heart_scene.instantiate()
    heart.depleted = true
    _lives_container.add_child(heart)

  var current_level: LevelEntry = LevelManager.curr_level()

  _level_title_label.text = current_level.title
  _description_label.text = current_level.description
  _description_label.start()
  pass


func fade_in() -> void:
  show()
  _animation_player.play("fade_in")
  await _animation_player.animation_finished
  pass


func fade_out() -> void:
  _animation_player.play("fade_out")
  await _animation_player.animation_finished
  hide()
  pass
