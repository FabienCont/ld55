extends EntityLogicInterface

class_name PlayerLogicComponent

func process_logic(delta:float) -> void:
	var has_collide_ice = false
	for i in entity.get_slide_collision_count():
		var collision = entity.get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.get("iced"):
			has_collide_ice= true
			
	if not has_collide_ice &&  entity.iced:
		entity.exit_iced_behaviour()
	elif has_collide_ice && not entity.iced:
		entity.enter_iced_behaviour()

	var water_ability =  entity.abilities_controller.get_ability("water_ability")
	var sun_ability =  entity.abilities_controller.get_ability("sun_ability")
	var ice_ability =  entity.abilities_controller.get_ability("ice_ability")
	var wind_ability =  entity.abilities_controller.get_ability("wind_ability")
	var thunder_ability =  entity.abilities_controller.get_ability("thunder_ability")
	var move_ability =  entity.abilities_controller.get_ability("move")
	var jump_ability =  entity.abilities_controller.get_ability("jump")
	
	if entity.has_die() == true:
		entity.sprite_component.play("Idle")
		return
	if jump_ability && jump_ability.is_executing == true:
		jump_ability.update(delta)
		return 
	entity.velocity_component.update_velocity(entity.velocity)
	entity.controller_component.updateControl(delta)
	if move_ability:
		move_ability.execute(delta)

	if entity.controller_component.has_move() : 
		SoundManager.playFootstepSound()
		entity.sprite_component.play("Walk")
		if entity.velocity_component.current_velocity.x < 0 :
			entity.sprite_component.flip_h = true
		else: 
			entity.sprite_component.flip_h = false 
	else:
		entity.sprite_component.play("Idle")
	#&& (not attack_ability || not attack_ability.is_executing)
	if entity.controller_component.has_jump() == true && jump_ability  :
		if entity.velocity_component is VelocityComponentUnderWater2D:
			if !jump_ability.is_executing && entity.controller_component.direction.y != 1:
				jump_ability.execute(delta)
		elif entity.is_on_floor() || entity.is_in_water == true:
			if entity.velocity_component is VelocityComponent2D:
				entity.is_in_water=false
			jump_ability.execute(delta)
	
	if entity.controller_component.is_using_control("water_ability") == true && water_ability: 
		water_ability.execute(delta)
		
	if entity.controller_component.is_using_control("sun_ability") == true && sun_ability: 
		sun_ability.execute(delta)
		
	if entity.controller_component.is_using_control("ice_ability") == true && ice_ability: 
		ice_ability.execute(delta)
	
	if entity.controller_component.is_using_control("thunder_ability") == true && thunder_ability: 
		thunder_ability.execute(delta)
		
	if entity.controller_component.is_using_control("wind_ability") == true && wind_ability: 
		wind_ability.execute(delta)


