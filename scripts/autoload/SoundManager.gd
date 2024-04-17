extends Node

@onready var _soundQueuesByName :Dictionary  = {}
@onready var _soundPoolsByName :Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	playBackgroundMenuSound()

func playBackgroundMenuSound():
	#get_sound_queue_by_name("BackgroundSoundQueue").play_sound_with_fade_in(2)
	pass
func stopBackgroundMenuSound():
	#get_sound_queue_by_name("BackgroundSoundQueue").stop_sound_with_fade_out(4)
	pass
func playBackgroundGameSound():
	#get_sound_queue_by_name("BackgroundGameSoundQueue").play_sound_with_fade_in(2)
	pass
func stopBackgroundGameSound():
	#get_sound_queue_by_name("BackgroundGameSoundQueue").stop_sound_with_fade_out(4)
	pass
func playFootstepSound():
	#get_sound_pool_by_name("FootstepSoundPool").play_random_sound()
	pass
func get_sound_queue_by_name(sound_name: String) -> SoundQueue :
	return _soundQueuesByName[sound_name]
func get_sound_pool_by_name(sound_name: String) -> SoundPool :
	return _soundPoolsByName[sound_name]
