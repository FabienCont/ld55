extends Ability

func init_ability(entity_init:Entity)-> void:
	super(entity_init)

func can_be_used()-> bool:
	return entity.has_die() != true
	
func execute(delta:float)->void:
	var nodes_in_group = entity.get_tree().get_nodes_in_group("waters")
	for node in nodes_in_group:
		translate_node_y(node,12.0*delta)
		
func translate_node_y(node, amount: float):
	var new_position = node.position
	new_position.y -= amount
	node.position = new_position
