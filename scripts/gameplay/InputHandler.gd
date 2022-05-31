extends Node

signal move(direction: Vector2)
signal attack()
signal reload()

var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

func _process(delta):
	handle_movement_input()
	handle_mouse_input()


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
