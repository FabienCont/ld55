extends EntityLogicInterface

class_name PlayerLogicComponent

func process_logic(delta:float) -> void:
	var water_ability =  entity.abilities_controller.get_ability("water_ability")
	var sun_ability =  entity.abilities_controller.get_ability("sun_ability")
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
	if entity.controller_component.has_jump() == true && jump_ability && jump_ability.can_be_used()  :
		jump_ability.execute(delta)
	
	if entity.controller_component.is_using_control("attack") == true && water_ability: 
		water_ability.execute(delta)
		
	if entity.controller_component.is_using_control("sun_ability") == true && sun_ability: 
		sun_ability.execute(delta)

