extends CharacterBody2D

@onready var cooldown: Timer = $Cooldown
@onready var spawner: Node2D = $Spawner
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

@export var speed: float = 120.0
@export var arc_strength: float = 40.0
@export var arc_speed: float = 6.0
@export var turn_speed: float = 5.0

var time: float = 0.0

@export var target: Node2D


func _physics_process(delta: float) -> void:
	if target == null:
		return

	time += delta

	var to_target: Vector2 = (target.global_position - global_position).normalized()

	var perpendicular: Vector2 = Vector2(-to_target.y, to_target.x)

	var arc_offset: Vector2 = perpendicular * sin(time * arc_speed) * arc_strength

	var desired_direction: Vector2 = (to_target + arc_offset * 0.01).normalized()

	rotation = desired_direction.angle() + deg_to_rad(90)

	velocity = velocity.lerp(desired_direction * speed, turn_speed * delta)

	move_and_slide()


func _on_cooldown_timeout() -> void:
	if !Global.game_start:
		return
	spawner.dropWeapon()
