extends Node2D

@export var currentBomb: PackedScene

func dropWeapon(weapon: PackedScene = currentBomb) -> void:
	var loadedWeapon: CharacterBody2D = weapon.instantiate()
	loadedWeapon.global_position = global_position
	loadedWeapon.global_rotation = global_rotation
	get_tree().root.add_child(loadedWeapon)
	loadedWeapon.drop()
