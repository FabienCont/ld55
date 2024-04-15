extends VelocityComponent2D

class_name VelocityComponentIced2D

func decelerate_x(delta):
	current_velocity.x *= 1- (delta * FRICTION)

func accelerate_to_x_velocity(x:float,delta:float):
	current_velocity.x += x * (delta * FRICTION)
