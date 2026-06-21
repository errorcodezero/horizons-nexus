extends Area2D

@export var damage: int = 1
@export var shape: Shape2D = CircleShape2D.new()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal hit(damage: int)

func _ready() -> void:
	collision_shape_2d.shape = shape

func _on_body_entered(_body: Node2D) -> void:
	print("detect")
	hit.emit(damage)
