extends CharacterBody2D

@onready var cooldown: Timer = $Cooldown
@onready var spawner: Node2D = $Spawner
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

@export var speed: float = 120.0
@export var arc_strength: float = 40.0
@export var arc_speed: float = 6.0
@export var turn_speed: float = 5.0
@export var stop_distance: float = 20.0

var time: float = 0.0
@export var target: Node2D


func _physics_process(delta: float) -> void:
	if !Global.game_start:
		return
	if target == null:
		return

	time += delta

	var to_target: Vector2 = target.global_position - global_position
	var dist := to_target.length()

	# ✅ STOP BEFORE CONTACT
	if dist < stop_distance:
		velocity = velocity.lerp(Vector2.ZERO, turn_speed * delta)
		move_and_slide()
		return

	var dir := to_target.normalized()

	var perpendicular := Vector2(-dir.y, dir.x)
	var arc_offset := perpendicular * sin(time * arc_speed) * arc_strength

	var desired_direction := (dir + arc_offset * 0.01).normalized()

	velocity = velocity.lerp(desired_direction * speed, turn_speed * delta)

	if velocity.length() > 0.1:
		rotation = velocity.angle() + PI/2

	move_and_slide()


func _on_cooldown_timeout() -> void:
	if !Global.game_start:
		return
	spawner.dropWeapon()
