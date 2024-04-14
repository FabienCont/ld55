extends Ability

func init_ability(entity_init:Entity)-> void:
	super(entity_init)

func can_be_used()-> bool:
	return entity.has_die() != true
	
func execute(delta:float)->void:
	var nodes_in_group = entity.get_tree().get_nodes_in_group("waters")
	for water in nodes_in_group:
		if water.has_method("push"):
			water.push(delta)

