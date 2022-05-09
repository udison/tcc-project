extends Node2D
class_name Weapon

func _physics_process(delta):
	rotate_to_mouse()
	
func rotate_to_mouse():
	look_at(get_global_mouse_position())
