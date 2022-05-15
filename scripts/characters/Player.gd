extends Entity
class_name Player

var motion: Vector2 = Vector2.ZERO
var looking_right: bool = true

@onready var anim_player = $AnimationPlayer

func _physics_process(delta: float):
	input_handler()
	move()
	rotate_to_mouse()
	print(speed)
	
func input_handler():
	motion.x = Input.get_axis('left', 'right')
	motion.y = Input.get_axis('up', 'down')
	motion = motion.normalized()
	
func move():
	if motion != Vector2.ZERO:
		velocity = motion * speed
		anim_player.play('Walk')
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		anim_player.play('Idle')

	move_and_slide()

func rotate_to_mouse():
	var mouse_x = get_global_mouse_position().x
	var mouse_distance_to_player = mouse_x - global_position.x
	
	if mouse_distance_to_player > 0 and not looking_right or mouse_distance_to_player < 0 and looking_right:
		looking_right = !looking_right
		flip_horizontal()
		
func flip_horizontal():
	scale.x = -1
