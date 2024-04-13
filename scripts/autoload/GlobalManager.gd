extends Node

@onready var intro_level: PackedScene  = preload("res://levels/IntroLevel.tscn")
@onready var menu: PackedScene  = preload("res://menus/Home.tscn")

var infos: Dictionary = {
	"level":0,
} 

var savedInfos: Dictionary = {
	
}

func reset():
	infos.level=0

func startLevel():
	savedInfos = infos.duplicate(true)

func endLevel():
	infos.level+=1

func goToMenu():
	SceneLoader.change_scene_to_packed(menu,SceneLoader.TransitionTypeEnum.INSTANT)
	SoundManager.stopBackgroundGameSound()
	SoundManager.playBackgroundMenuSound()

func goToNextLevel():
	SceneLoader.change_scene_to_packed(intro_level,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
	SoundManager.playBackgroundGameSound()
	SoundManager.stopBackgroundMenuSound()

func restartLevel():
	infos = savedInfos.duplicate(true)
	SceneLoader.change_scene_to_packed(intro_level,SceneLoader.TransitionTypeEnum.LOADING_SCREEN)
