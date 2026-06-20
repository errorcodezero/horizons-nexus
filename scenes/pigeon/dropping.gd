extends CharacterBody2D

@export_category("Stats")
@export var damage: float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	hitbox.get_child(0).disabled = true
	drop()
	
func drop() -> void:
	timer.start()
	animated_sprite_2d.set_frame_and_progress(0, 0)
	animated_sprite_2d.play("default")
	await timer.timeout
	animated_sprite_2d.hide()
	hitbox.get_child(0).disabled = false
