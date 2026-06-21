extends CharacterBody2D

@export var damage: float = 1
@export var blast_radius: float = 40.0

<<<<<<< HEAD:scenes/pigeon/components/dropping.gd
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
=======
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall_timer: Timer = $FallTimer

func _ready() -> void:
	fall_timer.timeout.connect(_explode)

func drop() -> void:
	animated_sprite.set_frame_and_progress(0, 0)
	animated_sprite.play("default")
	fall_timer.start()

func _explode() -> void:
	animated_sprite.hide()

	var space_state := get_world_2d().direct_space_state
	var query := PhysicsShapeQueryParameters2D.new()
	var circle := CircleShape2D.new()
	circle.radius = blast_radius
	query.shape = circle
	query.transform = Transform2D(0, global_position)
	query.collision_mask = 2
	query.collide_with_areas = true

	var results := space_state.intersect_shape(query)
	for result in results:
		var collider := result.collider as Node
		if collider and collider.has_method("take_damage"):
			collider.take_damage(damage)

	await get_tree().create_timer(0.5).timeout
>>>>>>> f1a7909239d8cc5214ce567f96a771038d0f7c9d:scenes/pigeon/dropping.gd
	queue_free()
