extends Node

func _ready() -> void:
	Signals.level_loaded.emit()
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
