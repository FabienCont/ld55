extends EntityLogicInterface

class_name PlayerLogicComponent

func process_logic(delta:float) -> void:
	var has_collide_ice = false
	var has_collide = false
	for i in entity.get_slide_collision_count():
		var collision = entity.get_slide_collision(i)
		var collider = collision.get_collider()
		has_collide = true
		if collider.get("iced"):
			has_collide_ice= true
			
	if not has_collide_ice && has_collide &&  entity.iced:
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
		if entity.is_in_water:
			entity.sprite_component.play("Swim")
		else :
			if entity.is_on_floor() : 
				SoundManager.playFootstepSound()
				entity.sprite_component.play("Walk")
			
		var direction = entity.get_current_direction() 
		if entity.get_current_direction().x< 0 :
			entity.sprite_component.flip_h = true
			entity.stick_slot.switch_side(direction)
		else: 
			entity.stick_slot.switch_side(direction)
			entity.sprite_component.flip_h = false 
	elif entity.is_on_floor() || entity.is_in_water == true:
		entity.sprite_component.play("Idle")
	#&& (not attack_ability || not attack_ability.is_executing)
	if entity.controller_component.has_jump() == true && jump_ability  :
		if entity.velocity_component is VelocityComponentUnderWater2D:
			if !jump_ability.is_executing && entity.controller_component.direction.y != 1:
				jump_ability.execute(delta)
				entity.sprite_component.play("Jump")
		elif entity.is_on_floor() || entity.is_in_water == true:
			if entity.velocity_component is VelocityComponent2D:
				entity.is_in_water=false
			entity.sprite_component.play("Jump")
			jump_ability.execute(delta)
	
	if entity.controller_component.is_using_control("water_ability") == true && water_ability: 
		use_ability(water_ability,delta)
		
	if entity.controller_component.is_using_control("sun_ability") == true && sun_ability: 
		use_ability(sun_ability,delta)
		
	if entity.controller_component.is_using_control("ice_ability") == true && ice_ability && not entity.is_in_water: 
		use_ability(ice_ability,delta)
		
	#if entity.controller_component.is_using_control("thunder_ability") == true && thunder_ability: 
		#use_ability(thunder_ability,delta)
		#thunder_ability.execute(delta)
		#
	#if entity.controller_component.is_using_control("wind_ability") == true && wind_ability: 
		#use_ability(wind_ability,delta)
		#wind_ability.execute(delta)

func use_ability(ability:Ability,delta:float):
	ability.execute(delta)
	entity.stick_slot.play(delta)
