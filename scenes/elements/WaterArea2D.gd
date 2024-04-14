extends Area2D

var gravity_water_space = SPACE_OVERRIDE_COMBINE_REPLACE
var gravity_water_direction = Vector2(0,-1)
var gravity_water:float = 955
var water_linear_space = SPACE_OVERRIDE_REPLACE
var water_linear_damp = 10

var gravity_ice_space = SPACE_OVERRIDE_REPLACE
var gravity_ice_direction = Vector2(0,0)
var gravity_ice:float = 0
var ice_linear_space = SPACE_OVERRIDE_REPLACE
var ice_linear_damp = 900

func froze():
	gravity_space_override = gravity_ice_space
	gravity_direction = gravity_ice_direction
	gravity = gravity_ice
	linear_damp = ice_linear_space
	linear_damp_space_override = ice_linear_damp
	froze_rigid_bodies()
	
func unfroze():
	gravity_space_override = gravity_water_space
	gravity_direction = gravity_water_direction
	gravity = gravity_water
	linear_damp = water_linear_space
	linear_damp_space_override = water_linear_damp


func unfroze_rigi_bodies():
		# Assuming 'area' is a reference to your Area2D node
	var overlapping_bodies = get_overlapping_bodies()

	# Iterate over the overlapping bodies
	for body in overlapping_bodies:
		# Check if the overlapping body is a RigidBody2D
		if body is RigidBody2D:
			# Do something with the RigidBody2D
			body.linear_velocity = Vector2(0.0,-10.0)
			
func froze_rigid_bodies():
	# Assuming 'area' is a reference to your Area2D node
	var overlapping_bodies = get_overlapping_bodies()

	# Iterate over the overlapping bodies
	for body in overlapping_bodies:
		# Check if the overlapping body is a RigidBody2D
		if body is RigidBody2D:
			# Do something with the RigidBody2D
			body.linear_velocity = Vector2.ZERO
