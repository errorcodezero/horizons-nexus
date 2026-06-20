extends CharacterBody2D

@export var linear_acceleration: int = 2
@export var angular_speed: float = PI/36
@onready var sprite_2d: Sprite2D = $Sprite2D

const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	var angle: float = PI/2;

	# Get the input linear_direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Vector2.ZERO;
	var input_linear_direction: float = Input.get_axis("Speed Up", "Slow Down")
	var angular_direction: float = Input.get_axis("Turn Left", "Turn Right")

	direction.y = input_linear_direction * sin(angular_direction)
	direction.x = input_linear_direction * cos(angular_direction)


	if direction:
		velocity += direction;
	else:
		velocity.y = move_toward(velocity.y, 0, linear_acceleration)
		velocity.x = move_toward(velocity.x, 0, linear_acceleration)

		
	if angular_direction:
		
		rotate(angular_speed * angular_direction)
	else:
		rotate(0)

	move_and_slide()
