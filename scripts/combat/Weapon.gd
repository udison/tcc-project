extends Node2D
class_name Weapon

@export var damage: float = 25.0
@export var mag_size: int = 30
@export var fire_rate: float = 100.0 # Bullets per minute
@export var reload_time: float = 2.0 # In seconds

var ammo: int = mag_size
var can_shoot: bool = true

@onready var muzzle: Node2D = $Muzzle
@onready var fire_timer: Timer = $FireTimer
@onready var reload_timer: Timer = $ReloadTimer

enum FireModes {
	SINGLE,
	AUTO
}

func _ready():
	fire_timer.wait_time = 60 / fire_rate
	reload_timer.wait_time = reload_time

func _physics_process(delta):
	rotate_to_mouse()
	input_handler()
	
func rotate_to_mouse():
	look_at(get_global_mouse_position())

func input_handler():
	if Input.is_action_pressed('fire'):
		fire()
	
	elif Input.is_action_pressed('reload'):
		reload()
		
func fire():
	if !can_shoot or ammo <= 0:
		return
	
	print('BANG')
	can_shoot = false
		
	if ammo > 0:
		fire_timer.start()
	else:
		reload()
	
func reload():
	print('reloading!')
	ammo = mag_size
	reload_timer.start()

func enable_shoot():
	can_shoot = true
