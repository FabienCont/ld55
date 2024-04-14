extends Ability

func has_requirement() -> bool:
	return entity.velocity_component is VelocityComponent2D
	
func init_ability(entity_init:Entity)-> void:
	super(entity_init)

func can_be_used()-> bool:
	return entity.has_die() != true

func get_velocity_component() -> VelocityComponent2D:
	return entity.velocity_component

func execute(delta:float)->void:
	var direction = entity.get_current_direction()
	var velocity_component = get_velocity_component()
	if direction == Vector2.ZERO:
		velocity_component.decelerate_x(delta)
		velocity_component.decelerate_y(delta)
	else:
		if direction.x == 0:
			velocity_component.decelerate_x(delta)
		else: 
			velocity_component.accelerate_in_x_direction(direction.x,delta)
		if direction.y == 0:
			velocity_component.decelerate_y(delta)
		else: 
			velocity_component.accelerate_in_y_direction(direction.y,delta)
	velocity_component.apply_gravity(delta)
	velocity_component.move(entity)
