extends CanvasLayer

@export var texture_progress_bar: TextureProgressBar

func _ready() -> void:
	Global.connect("get_speed", updateProgress)
	

func updateProgress(value: float) -> void:
	texture_progress_bar.value = value
