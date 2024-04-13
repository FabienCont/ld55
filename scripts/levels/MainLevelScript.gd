extends Control

@export var game_world: Node
@onready var ui_container = $SubViewportContainerUI/SubViewport2/VBoxContainerUI
@onready var pause_menu = $pause

@onready var is_paused: bool = false
@onready var level_up_in_queue: int = 0

func _ready() -> void:
	Signals.start_pause_menu.connect(show_pause_menu)
	Signals.end_pause_menu.connect(hide_pause_menu)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") && level_up_in_queue == 0:
		if is_paused==true:
			hide_pause_menu()
		else:
			show_pause_menu()
		
func pause_game() -> void:
	is_paused=true
	game_world.process_mode = PROCESS_MODE_DISABLED

func play_game() -> void:
	is_paused=false
	game_world.process_mode = PROCESS_MODE_INHERIT
	
func show_pause_menu() -> void:
	pause_menu.show()
	pause_game()
	
func hide_pause_menu() -> void:
	pause_menu.hide()
	play_game()
