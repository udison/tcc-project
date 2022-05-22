extends CharacterBody2D
class_name Entity

signal damage_took(amount)

@export var health: float = 100.0
@export var max_health: float = 100.0
@export var speed: float = 3.0

@onready var health_bar: HealthBar = $HealthBar

var motion: Vector2 = Vector2.ZERO
var looking_right: bool = true


func _ready():
	if health_bar != null:
		health_bar.init(self)


func take_damage(amount: float):
	print(str(name) + ' taking ' + str(amount) + ' damage')
	health -= amount
	damage_took.emit(health)
	
	if health <= 0:
		die()


func die():
	print(str(name) + ' dying')
	queue_free()


func flip_horizontal():
	scale.x = -1
	
	if health_bar != null:
		health_bar.scale.x = -health_bar.scale.x
