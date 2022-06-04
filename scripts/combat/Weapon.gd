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
@export var bullet_scene: PackedScene

var ammo: int = 0
var can_shoot: bool = true

@onready var muzzle: Node2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var reload_timer: Timer = $ReloadTimer
@onready var held_by_player: bool = get_parent().get_parent() is Player

enum FireModes {
	SINGLE,
	AUTO
}

func _ready():
	fire_timer.wait_time = 60 / fire_rate
	reload_timer.wait_time = reload_time
	ammo = mag_size
	
	if held_by_player:
		setup_listeners()


func setup_listeners():
	var input_handler = get_tree().get_root().get_node('InputHandler')
	
	input_handler.connect('attack', fire)
	input_handler.connect('reload', reload)


func fire():
	print(can_shoot)
	if !can_shoot or ammo <= 0:
		return
	
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.global_rotation = muzzle.global_rotation
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


func enable_shoot():
	can_shoot = true


func reload_finished():
	enable_shoot()
	ammo = mag_size
