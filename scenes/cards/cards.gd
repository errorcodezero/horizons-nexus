class_name CardBody
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var isActive: bool = false
var target_position: Vector2

func _on_mouse_entered() -> void:
	isActive = true

func _on_mouse_exited() -> void:
	isActive = false
