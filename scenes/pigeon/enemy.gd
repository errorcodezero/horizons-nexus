extends CharacterBody2D

@onready var cooldown: Timer = $Cooldown
@onready var spawner: Node2D = $Spawner
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func _on_cooldown_timeout() -> void:
	spawner.dropWeapon()
