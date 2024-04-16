extends Ability

func init_ability(entity_init:Entity)-> void:
	super(entity_init)

func can_be_used()-> bool:
	return entity.has_die() != true
	
func execute(delta:float)->void:
	var overlapping_areas = entity.power_area_2d.get_overlapping_areas()
	
	# Loop through the overlapping areas
	for area in overlapping_areas:
		var water = area.water
		if water.has_method("froze") && water.is_frozen==false:
			water.froze(delta)

