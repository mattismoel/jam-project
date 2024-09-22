extends Node2D

signal done

@export var _tower: NuclearTestTower
@export var _animation_player: AnimationPlayer

func _ready() -> void:
  _tower.warhead_dropped.connect(_on_warhead_dropped)


func _on_warhead_dropped() -> void:
  _animation_player.play("boom")
  pass


func explosion_done() -> void:
  print("Hello")
  LifeManager.game_over()
  # LevelManager.next_level()
  pass

