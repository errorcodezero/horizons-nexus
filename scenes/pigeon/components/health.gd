class_name health
extends Node2D

@export var healthValue: int = 10
@export var maxHealth: int = 10

func takeDamage(damage: int = 1) -> int:
	healthValue -= damage
	if healthValue < 0:
		healthValue = 0
	if healthValue > maxHealth:
		healthValue = maxHealth
	return healthValue
