extends Control
class_name BulletCounter

@onready var counter = $Counter
var equipped_weapon: Weapon = null

func _ready():
	connect_weapon_change()


func _process(delta):
	update_counter()


func connect_weapon_change():
	var player = get_tree().current_scene.get_node('Player')
	
	if !player:
		return
		
	var hand = player.get_node('Hand')
		
	if !hand:
		return
	
	hand.weapon_changed.connect(on_weapon_change)


func on_weapon_change(weapon: Weapon):
	equipped_weapon = weapon


func update_counter():
	if !counter:
		return
	
	if !equipped_weapon:
		counter.text = '--/--'
		return
	
	counter.text = str(equipped_weapon.ammo) + '/' + str(equipped_weapon.mag_size)
