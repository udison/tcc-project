extends Node2D
class_name Weapon

enum WeaponTypes {
	PRIMARY,
	SECONDARY
}

@export_enum(Primary, Secondary) var type: int = 1
@export var damage: float = 25.0
@export var mag_size: int = 30
@export var fire_rate: float = 100.0 # Bullets per minute
@export var reload_time: float = 2.0 # In seconds
@export var bullets_shot_once: int = 1
@export_range(0, 90) var spread_radius: float = 15.0 # In degrees
@export_range(1, 5) var spread_walking_multiplier: float = 1.3
@export var bullet_scene: PackedScene

var ammo: int = 0
var can_shoot: bool = true

@onready var muzzle: Node2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var reload_timer: Timer = $ReloadTimer
@onready var holder: Entity = get_parent().get_parent()
@onready var held_by_player: bool = holder is Player

enum FireModes {
	SINGLE,
	AUTO
}

func _ready():
	fire_timer.wait_time = 60 / fire_rate
	ammo = mag_size
	
	if held_by_player:
		setup_listeners()


func setup_listeners():
	var input_handler = get_tree().get_root().get_node('InputHandler')
	
	input_handler.connect('attack', fire)
	input_handler.connect('reload', reload)


func get_bullet_rotation():
	var spread_multiplier = 1 if held_by_player and holder.motion == Vector2.ZERO else spread_walking_multiplier
	var half_spread_degree = spread_radius * spread_multiplier / 2
	var random_spread = deg2rad(randf_range(-half_spread_degree, half_spread_degree))
	
	return muzzle.global_rotation + random_spread


func fire():
	if !can_shoot or ammo <= 0:
		return
	
	for i in bullets_shot_once:
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.global_rotation = get_bullet_rotation()
		bullet_instance.shot_by_player = held_by_player
		bullet_instance.damage = damage
		get_tree().current_scene.add_child(bullet_instance)
	ammo -= 1
	
	can_shoot = false
		
	if ammo > 0:
		fire_timer.start()
	else:
		reload()
	
func reload():
	if ammo == mag_size:
		return
	
	print('reloading!')
	
	can_shoot = false
	reload_timer.start(reload_time)


func reload_finished():
	print('reload finished!')
	enable_shoot()
	ammo = mag_size


func enable_shoot():
	can_shoot = true
