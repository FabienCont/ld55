extends Resource

class_name PlayerInfos

signal update_character
signal update_weapon_info
signal update_stats

#var player_stats: ResourceGroup = preload("res://data/all_players_stats.tres")
var playerData:PlayerStatsData = preload("res://data/stats/player_stat_data.tres")
@export var abilities_controller :AbilitiesController = AbilitiesController.new()
@export var inventory_controller :InventoryController = InventoryController.new()
@export var upgrades_controller :UpgradesController = UpgradesController.new()
@export var logic_component :EntityLogicInterface
@export var character_info :CharacterDatas
@export var stats_controller :StatsController
@export var effects :EffectsController = EffectsController.new()

func _init()-> void:
	stats_controller = playerData.export_to_stat_controller()
