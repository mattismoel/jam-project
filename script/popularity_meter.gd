@tool
class_name PopularityMeter
extends Node2D

const SKULL_OFFSET: int = 18
const SCREEN_MARGIN: int = 32
const HEIGHT_METER_WIDTH: int = 2

@export var _tower: Tower
@export var _skull: Sprite2D
@export var _gondola: Gondola


@export var _line_color: Color = Color.WHITE:
    set(_v):
        _line_color = _v
        queue_redraw()

@export var _meter_width: int = 5:
    set(_v):
        _meter_width = _v
        queue_redraw()


@export var _marker_count: int = 10:
    set(_v):
        _marker_count = _v
        queue_redraw()

@onready var _screen_size := Vector2(
  ProjectSettings.get_setting("display/window/size/viewport_width"),
  ProjectSettings.get_setting("display/window/size/viewport_height")
)

func _ready() -> void:
    _tower.height_changed.connect(queue_redraw)
    queue_redraw()

@onready var _draw_pos_bottom: Vector2 = Vector2(
    _screen_size.x - SCREEN_MARGIN,
    _tower.global_position.y - _tower.bottom_pos_y,
) - global_position


func _process(delta: float) -> void:
  queue_redraw()


func _draw() -> void:
    draw_height_meter()
    draw_skull()
    draw_score_markers()


func draw_score_markers() -> void:
    var _pixel_alignment_offset = Vector2.ONE/2.0

    for n in _marker_count+1:
        var score = float(n)/_marker_count
        var height = _tower.calculate_height_with_specific_popularity_score(score)
        var offset = Vector2.UP * 0.5

        var start_pos: Vector2 = _draw_pos_bottom + Vector2.UP * height

        var end_pos := start_pos + Vector2.LEFT * _meter_width

        start_pos += offset
        end_pos += offset

        draw_line(start_pos, end_pos, _line_color, 1)


    var start_pos := _draw_pos_bottom
    var end_pos := start_pos + Vector2.UP * (_tower.height + 1)

    var offset := Vector2.RIGHT * 0.5

    start_pos += offset
    end_pos += offset

    draw_line(start_pos, end_pos, _line_color, 1)


func draw_skull() -> void:
    var height = _tower.calculate_height_with_specific_popularity_score(_tower.minimum_score)

    var pos: Vector2 = _draw_pos_bottom + Vector2.UP * height

    draw_death_line(height)

    _skull.position = pos + Vector2.LEFT * SKULL_OFFSET
    pass


func draw_death_line(height: float) -> void:
  var start_pos := _draw_pos_bottom
  start_pos += Vector2.LEFT * _meter_width / 2.0
  var end_pos := start_pos + Vector2.UP * height
  draw_line(start_pos, end_pos, Color.RED, _meter_width)


func draw_height_meter() -> void:
  var start_pos: Vector2 = _draw_pos_bottom

  var end_pos: Vector2 = Vector2(start_pos.x, _gondola.global_position.y - global_position.y)

  var offset := Vector2.RIGHT * HEIGHT_METER_WIDTH

  start_pos += offset
  end_pos += offset


  draw_line(start_pos, end_pos, Color.GREEN, HEIGHT_METER_WIDTH)
  pass
