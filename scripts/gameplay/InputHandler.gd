extends Node

signal move(direction: Vector2)
signal attack()
signal reload()
signal equip(slot: int)

var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

func _process(delta):
	handle_movement_input()
	handle_mouse_input()
	handle_weapon_selection()


func handle_movement_input():
	direction.x = Input.get_axis('left', 'right')
	direction.y = Input.get_axis('up', 'down')
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		move.emit(direction)
	elif direction == Vector2.ZERO and last_direction != Vector2.ZERO:
		move.emit(Vector2.ZERO)
	
	last_direction = direction


func handle_mouse_input():
	if Input.is_action_just_pressed('reload'):
		reload.emit()
	elif Input.is_action_pressed('fire'):
		attack.emit()


func handle_weapon_selection():
	var slot: int = 0
	
	if Input.is_action_just_released('primary'): slot = 1
	if Input.is_action_just_released('secondary'): slot = 2
	
	if slot != 0:
		equip.emit(slot)
