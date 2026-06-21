extends Node2D

@export var dialog_data: SproutyDialogsDialogueData

func _ready() -> void:
	make_dialogues("SF")
	Global.connect("death", death)
	
func death() -> void:
	make_dialogues("DEAD")

func make_dialogues(dialog: String) -> void:
	Global.game_start = false
	var dialog_player = DialogPlayer.new()
	add_child(dialog_player)

	dialog_player.set_dialog(dialog_data, dialog)
	dialog_player.start()
