extends CharacterBody2D
class_name Entity

@export var health: float = 100.0
@export var speed: float = 3.0

var motion: Vector2 = Vector2.ZERO
var looking_right: bool = true

func take_damage(amount: float):
	print(str(name) + ' taking ' + str(amount) + ' damage')
	health -= amount
	
	if health <= 0:
		die()
		
func die():
	print(str(name) + ' dying')
	queue_free()

func flip_horizontal():
	scale.x = -1
