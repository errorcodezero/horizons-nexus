extends CharacterBody2D

@export_category("Stats")
@export var damage: float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall_length: Timer = $"Fall Length"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	collision_shape_2d.disabled = true
	
func drop() -> void:
	fall_length.start()
	animated_sprite_2d.set_frame_and_progress(0, 0)
	animated_sprite_2d.play("default")
	await fall_length.timeout
	animated_sprite_2d.hide()
	collision_shape_2d.disabled = false
	await get_tree().create_timer(4).timeout
	queue_free()
