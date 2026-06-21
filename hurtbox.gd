class_name HurtBox
extends Area2D

@export var shape: Shape2D = CircleShape2D.new()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal hurt(damage: int)

func _ready() -> void:
	collision_shape_2d.shape = shape

func _on_area_entered(area: HitBox) -> void:
	emit_signal("hurt", area.damage)
