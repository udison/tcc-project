extends CharacterBody2D
class_name Entity

@export var health: float = 100.0
@export var speed: float = 3.0

func take_damage(amount: float):
	print(str(name) + ' taking ' + str(amount) + ' damage')
	health -= amount
	
	if health <= 0:
		die()
		
func die():
	print(str(name) + ' dying')
	queue_free()
