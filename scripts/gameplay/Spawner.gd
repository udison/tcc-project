extends Node2D
class_name Spawner

@export var entity: PackedScene
@export var parent_node_path: NodePath
@export var max_timer_decrease_ratio: float = 0.3 # Per second
@export_range(0, 60) var min_timer: float = 5
@export_range(0, 60) var max_timer: float = 35

@onready var spawn_timer: Timer = $SpawnTimer

var parent_node: Node


func _ready():
	if entity == null:
		print('[WARNING] Spanwer (' + str(name) + ') has no Entity set!')
		queue_free()
	
	if parent_node_path == null:
		print('[WARNING] Spanwer (' + str(name) + ') has no Parent Node Path set!')
		queue_free()
	
	parent_node = get_node(parent_node_path)
	prepare()


func _process(delta):
	if max_timer > min_timer + 3:
		max_timer -= max_timer_decrease_ratio * delta


func prepare():
	var spawn_time: float = randf_range(min_timer, max_timer)
	
	spawn_timer.start(spawn_time)
	print('New entity spawning in ' + str(spawn_time) + ' second(s)')


func spawn():
	var instance = entity.instantiate()
	
	instance.global_position = global_position
	parent_node.add_child(instance)
	
	prepare()


func _on_enter_screen():
	spawn_timer.stop()


func _on_exit_screen():
	spawn_timer.start()
