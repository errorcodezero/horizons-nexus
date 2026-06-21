extends Node2D

@export var dialog_data: SproutyDialogsDialogueData

func _ready() -> void:
	pass

func make_dialogues(dialog: String) -> void:
	Global.game_start = false
	var dialog_player = DialogPlayer.new()
	add_child(dialog_player)

	dialog_player.dialog_ended.connect(_on_dialog_ended)
	dialog_player.set_dialog(dialog_data, dialog)
	dialog_player.start()


func _on_dialog_ended() -> void:
	Global.game_start = true
