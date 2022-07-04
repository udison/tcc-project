extends Node
class_name Inventory

@export var first_slot: PackedScene
@export var second_slot: PackedScene

@onready var hand: Hand = get_parent().get_node('Hand')

var equipped_slot: int = 0

func _ready():
	if equipped_slot == 0:
		var slot_to_equip: int = 0
		
		if first_slot  != null: slot_to_equip = 1
		elif second_slot != null: slot_to_equip = 2
		
		equip(slot_to_equip)
	
	setup_listeners()


func setup_listeners():
	var input_handler = get_tree().get_root().get_node('InputHandler')
	
	input_handler.connect('equip', equip)


func equip(slot: int):
	if slot <= 0:
		return
	
	var weapon_to_equip: PackedScene = null
	
	match slot:
		1: weapon_to_equip = first_slot
		2: weapon_to_equip = second_slot
	
	if weapon_to_equip == null:
		return
	
	hand.equip(weapon_to_equip)
