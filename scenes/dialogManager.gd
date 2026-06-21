extends Node2D

@export var dialog_data: SproutyDialogsDialogueData

func _ready() -> void:
	make_dialogues("SF")

func make_dialogues(dialog: String) -> void:
	var dialog_player = DialogPlayer.new()
	add_child(dialog_player)

	dialog_player.set_dialog(dialog_data, dialog)
	dialog_player.start()
