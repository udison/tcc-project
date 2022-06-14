extends CharacterBody2D
class_name Entity

signal damage_took(amount)

@export var health: float = 100.0
@export var max_health: float = 100.0
@export var speed: float = 3.0

@onready var health_bar: HealthBar = $HealthBar
@onready var sprite: Sprite2D = $Sprite
@onready var blink_effect_timer: Timer = $BlinkEffectTimer

var motion: Vector2 = Vector2.ZERO
var looking_right: bool = true


func _ready():
	if health_bar != null:
		health_bar.init(self)


func take_damage(amount: float):
	print(str(name) + ' taking ' + str(amount) + ' damage')
	health -= amount
	damage_took.emit(health)
	damage_blink_animation()
	
	if health <= 0:
		die()


func die():
	print(str(name) + ' dying')
	queue_free()


func flip_horizontal(things_to_unflip: Array = []):
	scale.x = -1
	
	for thing in things_to_unflip:
		thing.scale.x = -thing.scale.x


func damage_blink_animation():
	sprite.modulate = Color(100, 100, 100)
	blink_effect_timer.start(.1)


func reset_modulate():
	sprite.modulate = Color.WHITE
