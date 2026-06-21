class_name Health
extends Node2D

@export var healthValue: int = 10
@export var maxHealth: int = 10

signal hit(damage: int)
signal update

func _ready() -> void:
	connect("hit", takeDamage)
	
func takeDamage(damage: int = 1) -> int:
	emit_signal("update")
	healthValue -= damage
	if healthValue < 0:
		healthValue = 0
		print("dead")
	if healthValue > maxHealth:
		healthValue = maxHealth
	return healthValue
