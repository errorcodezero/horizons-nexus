extends CharacterBody2D

@export var damage: float = 1
@export var blast_radius: float = 40.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall_timer: Timer = $"Fall Length"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitbox: HitBox = $Hitbox

func _ready() -> void:
	fall_timer.timeout.connect(_explode)

func drop() -> void:
	animated_sprite_2d.set_frame_and_progress(0, 0)
	hitbox.monitoring = false
	animated_sprite_2d.play("default")
	fall_timer.start()

func _explode() -> void:
	animated_sprite_2d.hide()
	hitbox.monitoring = true
	#var space_state := get_world_2d().direct_space_state
	#var query := PhysicsShapeQueryParameters2D.new()
	#var circle := CircleShape2D.new()
	#circle.radius = blast_radius
	#query.shape = circle
	#query.transform = Transform2D(0, global_position)
	#query.collision_mask = 4
	#query.collide_with_areas = true
#
	#var results := space_state.intersect_shape(query)
	#for result in results:
		#var collider := result.collider as Node
		#if collider and collider.has_method("take_damage"):
			#collider.take_damage(damage)

	await get_tree().create_timer(0.5).timeout
	queue_free()
