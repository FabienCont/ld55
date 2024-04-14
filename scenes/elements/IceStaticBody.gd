extends StaticBody2D

var iced:bool = true
func toggle_collision_shapes(disabled:bool):
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is CollisionShape2D:
			child.disabled = disabled
func froze():
	toggle_collision_shapes(false)
	
func unfroze():
	toggle_collision_shapes(true)
	
