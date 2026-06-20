extends Node2D

@export var currentBomb: PackedScene

func dropBomb(bomb: PackedScene) -> void:
	var loadedBomb: CharacterBody2D = bomb.instantiate()
	get_tree().root.add_child(loadedBomb)
	loadedBomb.global_position = global_position
	loadedBomb.drop()
