extends Entity

class_name PlayerEntity
@export var controller_component: ControllerInterface2D

@onready var velocity_component_underwater: VelocityComponent2D = $VelocityComponentUnderWater
@onready var velocity_component_on_ground: VelocityComponent2D = $VelocityComponent
@onready var velocity_component_on_ice: VelocityComponent2D =$VelocityComponentIced2d

@export var player_info: PlayerInfos

@onready var stick_slot: Node2D = $stick_slot

@onready var power_area_2d : Area2D=$PowerArea2D

@onready var olga = preload("res://assets/sprites/characters/olga.aseprite")
var is_in_water:bool = false
var timer_get_out_water:Timer
var iced =false
func _ready():
	sprite_component = get_node("SpriteComponent")
	init_player(player_info)

func init_player(player_info_init :PlayerInfos) -> void:
	init_entity(player_info_init.stats_controller,player_info_init.upgrades_controller,player_info_init.abilities_controller,player_info_init.logic_component)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	player_info.abilities_controller = abilities_controller
	#var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	#var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	var movement_speed_stat = stats_controller.get_current_stat(StatsConstEntity.names.movement_speed)
	var acceleration_stat = stats_controller.get_current_stat(StatsConstEntity.names.acceleration)
	velocity_component_on_ice.init(movement_speed_stat.value,acceleration_stat.value)
	set_sprite_component(player_info.character_info.sprite.instantiate())
	Signals.player_ready.emit(self)

func _process(delta: float) -> void:
	logic_component.process_logic(delta)

func get_current_direction() -> Vector2:
	return controller_component.get_current_direction()
	
func hurt(attack :AttackInterface):
	logic_component.hurt_logic(attack)

func die():
	logic_component.die_logic()

func collect(loot : Loot) -> void:
	logic_component.collect_logic(loot)

func enter_iced_behaviour():
	iced = true
	velocity_component = velocity_component_on_ice

func exit_iced_behaviour():
	iced = false
	velocity_component = velocity_component_on_ground

	
func enter_water():
	velocity_component = velocity_component_underwater
	is_in_water = true
	if timer_get_out_water:
		timer_get_out_water.queue_free()

func exit_water():
	velocity_component = velocity_component_on_ground
	timer_get_out_water = Timer.new()
	timer_get_out_water.one_shot = true
	timer_get_out_water.timeout.connect(reset_state_water)
	add_child(timer_get_out_water)
	timer_get_out_water.start(0.35)

func reset_state_water():
	is_in_water = false
