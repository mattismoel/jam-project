extends State

@export var _warhead: Node2D
@export var _drop_pos: Marker2D
@export var _tower: NuclearTestTower

func enter() -> void:
  var tween := create_tween()
  tween.tween_property(_warhead, "position:y", _drop_pos.position.y, 0.5)\
  .set_ease(Tween.EASE_IN)\
  .set_trans(Tween.TRANS_CUBIC)

  await tween.finished

  _tower.warhead_dropped.emit()
