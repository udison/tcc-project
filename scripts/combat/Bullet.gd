extends Node2D
class_name Bullet

@export var DAMAGE: float = 25.0
@export var VELOCITY: float = 5.0

@onready var area: Area2D = $Area

var shot_by_player: bool = false

func _ready():
	var new_collision_mask: int = 0
	if shot_by_player:
		new_collision_mask = PhysicsLayers.WORLD | PhysicsLayers.ENEMIES
	else:
		new_collision_mask = PhysicsLayers.WORLD | PhysicsLayers.PLAYER
		
	print(1 | 5)
	area.set_collision_mask(new_collision_mask)

func _physics_process(delta):
	position += Vector2.RIGHT * VELOCITY

func _on_body_entered(body):
	if body is Entity:
		body.take_damage(DAMAGE)
		queue_free()
