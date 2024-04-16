extends Control

@export var game_world: Node
@onready var ui_container = $SubViewportContainerUI/SubViewport2/VBoxContainerUI

@onready var is_paused: bool = false
@onready var level_up_in_queue: int = 0
		
func pause_game() -> void:
	is_paused=true
	game_world.process_mode = PROCESS_MODE_DISABLED

func play_game() -> void:
	is_paused=false
	game_world.process_mode = PROCESS_MODE_INHERIT
