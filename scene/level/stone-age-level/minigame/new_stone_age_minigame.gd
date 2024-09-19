extends Minigame

@export var force_per_hit: float = 100

@export_category("References")
@export var projectile: Node2D
@export var mammoth: Node2D
@export var animation_of_mammoth: AnimatedSprite2D

func _ready() -> void:
    super()
    projectile.target_hit.connect(_on_target_hit)
    
func _on_target_hit() -> void:
    animation_of_mammoth.speed_scale += 0.5
    mammoth.direction*=-1
    mammoth.speed+=10
    
    force_buildup += force_per_hit

func _on_game_timer_timeout() -> void:
  finished.emit(force_buildup)
  pass
