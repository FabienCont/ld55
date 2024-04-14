extends Ability

func has_requirement() -> bool:
	return entity.velocity_component is VelocityComponent2D
	
func init_ability(entity_init:Entity)-> void:
	super(entity_init)
	
func get_velocity_component() -> VelocityComponent2D:
	return entity.velocity_component

func can_be_used()-> bool:
	return entity.has_die() != true 
	
func execute(delta:float)->void:
	var velocity_component = get_velocity_component()
	velocity_component.jump()
	velocity_component.apply_gravity(delta)
	velocity_component.move(entity)
