class_name Building
extends Area2D

@export var max_health: int = 3
@export var building_texture: Texture2D

var health: int
var destroyed: bool = false

signal on_destroyed

func _ready() -> void:
	health = max_health
	$Sprite2D.texture = building_texture
	var tex_size = building_texture.get_size()
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = tex_size
	Global.register_building()

func _draw() -> void:
	if health < max_health and not destroyed:
		var bar_width := 24.0
		var bar_height := 3.0
		var offset_y := 18.0

		draw_rect(Rect2(-bar_width / 2, offset_y, bar_width, bar_height), Color(0.1, 0.1, 0.1))
		var ratio := float(health) / max_health
		var color := Color(1, 0, 0).lerp(Color(0, 1, 0), ratio)
		draw_rect(Rect2(-bar_width / 2, offset_y, bar_width * ratio, bar_height), color)

func take_damage(amount: int) -> void:
	if destroyed:
		return
	health -= amount
	if health <= 0:
		destroyed = true
		on_destroyed.emit()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		Global.building_destroyed()
	else:
		modulate = Color.RED
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 0.15)
		queue_redraw()
