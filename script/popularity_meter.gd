@tool
class_name PopularityMeter
extends Node2D

@export var _tower: Tower
@export var _skull: Sprite2D

@export var _line_color: Color = Color.WHITE:
    set(_v):
        _line_color = _v
        queue_redraw()

@export var _line_offset: Vector2i = Vector2i(0,0):
    set(_v):
        _line_offset = _v
        queue_redraw()

@export var _skull_offset: Vector2i = Vector2i(0,0):
    set(_v):
        _skull_offset = _v
        queue_redraw()
        
@export var _line_length: int = 5:
    set(_v):
        _line_length = _v
        queue_redraw()

@export var _marker_count: int = 10:
    set(_v):
        _marker_count = _v
        queue_redraw()

var _initial_position: Vector2i

func _ready() -> void:
    _tower.height_changed.connect(queue_redraw)
    queue_redraw()

func _draw() -> void:
    _initial_position = Vector2i(_tower.global_position - _tower.position) + _line_offset - Vector2i(0,_tower.bottom_pos_y)
    draw_skull()
    draw_score_markers()
    
func draw_score_markers() -> void:
    var _pixel_alignment_offset = Vector2.ONE/2.0
    
    for n in _marker_count+1:
        var score = float(n)/_marker_count
        var height = _tower.calculate_height_with_specific_popularity_score(score)
        
        var start_draw_pos = Vector2(_initial_position) + Vector2.DOWN/2.0 - Vector2(0,height)
        var end_draw_pos = start_draw_pos + Vector2(_line_length,0)
        draw_line(Vector2(start_draw_pos)-Vector2(0,1),Vector2(end_draw_pos)-Vector2(0,1),_line_color,1)
        
    draw_line(Vector2(_initial_position)+Vector2.LEFT/2.0, Vector2(_initial_position - Vector2i(0, _tower.calculate_height_with_specific_popularity_score(1)+1))+Vector2.LEFT/2.0, _line_color,1)

func draw_skull() -> void:
    var height = _tower.calculate_height_with_specific_popularity_score(_tower.minimum_score)
    
    var skull_pos = _initial_position - Vector2i(3,height)
    var end_draw_pos = skull_pos + Vector2i(_line_length+3,0)

    draw_line(Vector2(_initial_position)+Vector2(_line_length/2.0,0)+Vector2.UP/2.0, Vector2(_initial_position - Vector2i(0, height))+Vector2(_line_length/2.0,0)+Vector2.UP/2.0, Color.RED,_line_length)
    _skull.position = skull_pos + _skull_offset
