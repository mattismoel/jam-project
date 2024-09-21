@tool
class_name PopularityMeter
extends Node2D

@export var _tower: Tower
@export var _bottom_pos: Vector2:
    set(_v):
        _bottom_pos = _v
        queue_redraw()

@export var _line_color: Color = Color.WHITE:
    set(_v):
        _line_color = _v
        queue_redraw()

@export var _line_offset: Vector2i:
    set(_v):
        _line_offset = _v
        queue_redraw()
        
@export var _line_length: int = 5:
    set(_v):
        _line_length = _v
        queue_redraw()

@export var _marker_count: int = 10:
    set(_v):
        _marker_count = _v
        queue_redraw()

func _ready() -> void:
    _tower.height_changed.connect(queue_redraw)
    queue_redraw()

func _draw() -> void:
    draw_score_markers()
    
func draw_score_markers() -> void:
    var initial_pos = Vector2i(_tower.global_position - _tower.position + _bottom_pos) + _line_offset
    var pixel_alignment_offset = Vector2.ONE/2
    
    for n in _marker_count+1:
        var score = float(n)/_marker_count
        var height = _tower.calculate_height_with_specific_popularity_score(score)
        
        var start_draw_pos = initial_pos - Vector2i(0,height)
        var end_draw_pos = start_draw_pos + Vector2i(_line_length,0)
        draw_line(Vector2(start_draw_pos)+pixel_alignment_offset-Vector2(0,1),Vector2(end_draw_pos)+pixel_alignment_offset-Vector2(0,1),_line_color,1)
        
    draw_line(Vector2(initial_pos), Vector2(initial_pos - Vector2i(0, _tower.calculate_height_with_specific_popularity_score(1)+1)), _line_color,1)
