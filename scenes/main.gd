extends Node2D

@onready var city_sprite: Sprite2D = $"city/San Francisco"

func _ready() -> void:
	SproutyDialogs.signal_event.connect(_on_dialog_signal)
	SproutyDialogs.start_dialog(
		preload("res://scenes/dialog/greg_speech.tres"),
        "SF"
	)

func _on_dialog_signal(signal_id: String, args: Array) -> void:
	match signal_id:
		"change_background":
			city_sprite.hide()
			city_sprite.texture = load(args[0])
			city_sprite.show()
		"restore_background":
			city_sprite.texture = preload("res://assets/dystopia.png")
