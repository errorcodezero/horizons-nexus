extends Node

signal get_speed(velocity: float)
signal score_changed(new_score: int)
signal city_cleared


var score: int = 0
var buildings_in_level: int = 0
var buildings_destroyed_count: int = 0
var game_start: bool = true

func register_building() -> void:
	buildings_in_level += 1

func building_destroyed() -> void:
	score += 100
	buildings_destroyed_count += 1
	score_changed.emit(score)
	if buildings_destroyed_count >= buildings_in_level:
		city_cleared.emit()
