class_name bullet
extends CharacterBody2D

@export var damage: int = 1
@export var speed: float = 40

func _ready() -> void:
	velocity = Vector2.UP.rotated(rotation) * speed

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func _on_hitbox_hit(_damage: int) -> void:
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func drop() -> void:
	pass
