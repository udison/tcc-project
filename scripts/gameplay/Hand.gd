extends Node2D
class_name Hand

signal weapon_changed(weapon: Weapon)

var equipped_weapon: Weapon = null
var bullet_counter: BulletCounter = null

#func _ready():
	#bullet_counter = get_tree().current_scene.get_node('HUD/Footer/BulletCounter')
	
	#if bullet_counter:
	#	bullet_counter.connect('weapon_changed', bullet_counter.on_weapon_change)
	
	#print(equipped_weapon)
	#print(bullet_counter)


func equip(weapon: PackedScene):
	if weapon == null:
		return
	
	if equipped_weapon != null:
		equipped_weapon.queue_free()
	
	equipped_weapon = weapon.instantiate()
	add_child(equipped_weapon)
	equipped_weapon.position = Vector2.ZERO
	weapon_changed.emit(equipped_weapon)
