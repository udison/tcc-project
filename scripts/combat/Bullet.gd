extends Node2D
class_name Bullet

@export var DAMAGE: float = 25.0
@export var VELOCITY: float = 5.0

@onready var area: Area2D = $Area
@onready var lifespan_timer: Timer = $LifespanTimer

var shot_by_player: bool = false

func _ready():
	var collision_mask: int = 0

	if shot_by_player:
		collision_mask = PhysicsLayers.WORLD | PhysicsLayers.ENEMIES
	else:
		collision_mask = PhysicsLayers.WORLD | PhysicsLayers.PLAYER

	area.set_collision_mask(collision_mask)

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(global_rotation) * VELOCITY

func _on_body_entered(body):
	if body is Entity:
		body.take_damage(DAMAGE)
		destroy()
		
func destroy():
	queue_free()
