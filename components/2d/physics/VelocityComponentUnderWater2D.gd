extends VelocityComponent2D

class_name VelocityComponentUnderWater2D

func calcul_jump_velocity() -> float:
	return ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	
func  calcul_jump_gravity() -> float:
	return ((2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	
func  calcul_fall_gravity() -> float:
	return  ((2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func get_gravity() -> float:
	return  jump_gravity if current_velocity.y < 0.0 else fall_gravity
	
func decelerate_y(delta):
	current_velocity.y *= 1- (delta * FRICTION)

func accelerate_in_y_direction(y_direction: float, delta:float):
	return accelerate_to_y_velocity(y_direction * (movement_speed/2) ,delta)
