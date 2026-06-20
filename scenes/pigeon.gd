extends CharacterBody2D

@export var max_speed: int = 150
@export var min_speed: int = 10
@export var acceleration: int = 20
@export var drag: int = 2
@export var angular_speed: float = PI/36
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var input_linear: float = Input.get_axis("Slow Down", "Speed Up")
	var input_angular: float = Input.get_axis("Turn Left", "Turn Right")

	rotate(input_angular * angular_speed)

	if input_linear > 0:
		var forward = Vector2.UP.rotated(rotation)
		velocity = velocity.move_toward(forward * max_speed, acceleration)
	elif velocity.length() < min_speed:
		velocity = Vector2.UP.rotated(rotation) * min_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag)

	move_and_slide()
