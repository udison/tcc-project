extends Node2D
class_name Hand

var equipped_weapon: Weapon = null

func equip(weapon: PackedScene):
	if weapon == null:
		return
	
	if equipped_weapon != null:
		equipped_weapon.queue_free()
	
	equipped_weapon = weapon.instantiate()
	add_child(equipped_weapon)
	equipped_weapon.position = Vector2.ZERO
