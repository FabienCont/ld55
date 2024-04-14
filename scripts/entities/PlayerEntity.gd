extends Entity

@export var controller_component: ControllerInterface2D

@onready var velocity_component_underwater: VelocityComponent2D = $VelocityComponentUnderWater
@onready var velocity_component_on_ground: VelocityComponent2D = $VelocityComponent

@export var player_info: PlayerInfos

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	init_player(player_info)

func init_player(player_info_init :PlayerInfos) -> void:
	init_entity(player_info_init.stats_controller,player_info_init.upgrades_controller,player_info_init.abilities_controller,player_info_init.logic_component)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	player_info.abilities_controller = abilities_controller
	var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
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

func enter_water():
	velocity_component = velocity_component_underwater
	print("enter_water")
func exit_water():
	velocity_component = velocity_component_on_ground
	print("exit_water")
	
