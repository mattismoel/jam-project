@tool
class_name FishPump
extends Node2D

signal sucked_fish
signal suck
signal stop_suck

@export var _pin: Node2D
@export var _rope: VerletRope

@export var _suction_area: Area2D

@export var _movement_state_machine: StateMachine
@export var _suction_state_machine: StateMachine

@export var _move_state: State
@export var _suck_state: State

var affected_fish: Array[Fish] = []


func _ready() -> void:
  if Engine.is_editor_hint():
    return

  _rope.set_start(_pin.global_position)

  _suction_area.area_entered.connect(func(_a): _recalculate_contained_fish())
  _suction_area.area_exited.connect(func(_a): _recalculate_contained_fish())
  pass


func allow_movement() -> void:
  _movement_state_machine.change_state(_move_state)
  pass


func allow_suction() -> void:
  _suction_state_machine.change_state(_suck_state)
  pass


func _recalculate_contained_fish() -> void:
  var overlaps := _suction_area.get_overlapping_areas()

  for area in overlaps:
    if area is not Fish:
      continue

    if affected_fish.has(area):
      continue

    affected_fish.append(area)

  for fish in affected_fish:
    if !is_instance_valid(fish):
      continue

    if !overlaps.has(fish):
      affected_fish.erase(fish)
  pass
