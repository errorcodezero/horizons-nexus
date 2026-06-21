class_name HitBox
extends Area2D

@export var damage: int = 1
@export var shape: Shape2D = CircleShape2D.new()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal target

func _ready() -> void:
	collision_shape_2d.shape = shape

func _on_area_entered(area: Area2D) -> void:
	var heath = area.get_node_or_null("Health")
	if heath:
		heath.emit_signal("hit", damage)
		emit_signal("target")

func _on_body_entered(body: Node2D) -> void:
	var heath = body.get_node_or_null("Health")
	if heath:
		heath.emit_signal("hit", damage)
		emit_signal("target")
