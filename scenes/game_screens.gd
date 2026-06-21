extends CanvasLayer

@onready var dialog_manager: Node2D = get_node("/root/main/Node2D")
@onready var background: TextureRect = $Background
@onready var start_screen: Control = $StartScreen
@onready var victory_screen: Control = $VictoryScreen
@onready var death_screen: Control = $DeathScreen
@onready var victory_score: Label = $VictoryScreen/Score
@onready var death_score: Label = $DeathScreen/Score


func _ready() -> void:
	show_start()
	Global.city_cleared.connect(_on_city_cleared)
	Global.death.connect(_on_death)


func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("Action"):
		return
	if start_screen.visible:
		dialog_manager.make_dialogues("SF")
		background.hide()
		start_screen.hide()
	elif victory_screen.visible or death_screen.visible:
		get_tree().reload_current_scene()


func show_start() -> void:
	Global.game_start = false
	background.show()
	start_screen.show()
	victory_screen.hide()
	death_screen.hide()


func _on_city_cleared() -> void:
	Global.game_start = false
	background.show()
	start_screen.hide()
	death_screen.hide()
	victory_score.text = str(Global.score)
	victory_screen.show()


func _on_death() -> void:
	Global.game_start = false
	background.show()
	start_screen.hide()
	victory_screen.hide()
	death_score.text = str(Global.score)
	death_screen.show()
