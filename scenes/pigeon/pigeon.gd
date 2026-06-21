extends CharacterBody2D

@export var max_speed: int = 150
@export var min_speed: int = 20
@export var acceleration: int = 20
@export var drag: int = 2
@export var angular_speed: float = PI/36

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cooldown: Timer = $Cooldown
@onready var spawner: Node2D = $Spawner
@onready var health: Health = $Health

var input_linear: float
var input_angular: float

func _unhandled_input(event: InputEvent) -> void:
	if !Global.game_start:
		return
	if event.is_action_pressed("Action"):
		if cooldown.is_stopped():
			spawner.dropWeapon(preload("res://scenes/pigeon/components/dropping.tscn"))
			cooldown.start()

func _physics_process(_delta: float) -> void:
	if !Global.game_start:
		return
	input_linear = Input.get_axis("Slow Down", "Speed Up")
	input_angular = Input.get_axis("Turn Left", "Turn Right")

	rotate(input_angular * angular_speed)

	if input_linear > 0:
		velocity = velocity.move_toward(
			Vector2.UP.rotated(rotation) * 
			max_speed, acceleration
		)
		Global.emit_signal("get_speed", velocity.length())
	elif velocity.length() < min_speed:
		velocity = Vector2.UP.rotated(rotation) * min_speed
		Global.emit_signal("get_speed", velocity.length())
	elif input_linear == -1:
		velocity = velocity.move_toward(Vector2.ZERO, drag * 2)
		Global.emit_signal("get_speed", velocity.length())
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag)
		Global.emit_signal("get_speed", velocity.length())
 
	move_and_slide()

func _on_hitbox_hit(damage: int) -> void:
	if health.takeDamage(damage) == 0:
		Global.emit_signal("death")
