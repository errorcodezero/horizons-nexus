extends CharacterBody2D

@export var max_speed: int = 150
@export var min_speed: int = 20
@export var acceleration: int = 20
@export var drag: int = 2D
@export var angular_speed: float = PI/36D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer

var input_linear: float
var input_angular: float




func _physics_process(_delta: float) -> void:
	var input_linear: float = Input.get_axis("Slow Down", "Speed Up")
	var input_angular: float = Input.get_axis("Turn Left", "Turn Right")

	rotate(input_angular * angular_speed)

	if input_linear > 0:
		velocity = velocity.move_toward(
			Vector2.UP.rotated(rotation) * 
			max_speed, acceleration
		)
	elif velocity.length() < min_speed:
		velocity = Vector2.UP.rotated(rotation) * min_speed
		Global.emit_signal("get_speed", velocity.length())
	elif input_linear == -1:
		velocity = velocity.move_toward(Vector2.ZERO, drag*2)
		Global.emit_signal("get_speed", velocity.length())
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag)
		Global.emit_signal("get_speed", velocity.length())

	move_and_slide()
