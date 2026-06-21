class_name bullet
extends CharacterBody2D

@export var damage: int = 1
@export var speed: float = 40
@onready var hitbox: HitBox = $Hitbox

func _ready() -> void:
	velocity = Vector2.UP.rotated(rotation) * speed
	hitbox.connect("target", target)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func target() -> void:
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	target()

func drop() -> void:
	pass
