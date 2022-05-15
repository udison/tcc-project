extends Entity
class_name Enemy

@export var attack_cooldown: float = 0.5
@export var stop_distance: float = 100.0
@export var min_idle_time: float = 2.0
@export var max_idle_time: float = 6.0
@export var min_walk_time: float = 1.5
@export var max_walk_time: float = 3.0

@onready var patrol_timer: Timer = $PatrolTimer
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hand: Node2D = $Hand

@onready var player = get_tree().current_scene.get_node('Player')

var is_chasing_player: bool = false

func _ready():
	walk_to_random_location()


func _physics_process(delta):
	move()
	
	if is_chasing_player:
		look_to_player()


func move():
	if is_chasing_player:
		walk_to_player()
	
	if motion != Vector2.ZERO:
		velocity = motion * speed
		anim_player.play('Walk')
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		anim_player.play('Idle')
		
	var distance_to_player = global_position.direction_to(player.global_position).x
		
	if ((motion.x > 0 or distance_to_player > 0 and is_chasing_player) and not looking_right) or ((motion.x < 0 or distance_to_player < 0 and is_chasing_player) and looking_right):
		looking_right = !looking_right
		flip_horizontal()
	
	move_and_slide()


func look_to_player():
	hand.look_at(player.global_position)


func walk_to_player():
	if global_position.distance_to(player.global_position) > stop_distance:
		motion = global_position.direction_to(player.global_position)
	else:
		motion = Vector2.ZERO


func walk_to_random_location():
	if is_chasing_player:
		return
	
	var random_rotation = randf_range(0, 360)
	var random_motion = Vector2(1, 1).rotated(deg2rad(random_rotation))
	
	motion = random_motion.normalized()
	
	patrol_timer.start(randf_range(min_walk_time, max_walk_time))


func _on_patrol_timer_timeout():
	if motion != Vector2.ZERO:
		motion = Vector2.ZERO
		patrol_timer.start(randf_range(min_idle_time, max_idle_time))
	else:
		walk_to_random_location()


func _on_detection_area_body_entered(body):
	if body is Player:
		chase_player()


func _on_detection_area_body_exited(body):
	if body is Player:
		stop_chase_player()


func chase_player():
	is_chasing_player = true


func stop_chase_player():
	is_chasing_player = false
	hand.global_rotation = 0

