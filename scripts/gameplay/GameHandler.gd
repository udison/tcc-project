extends Node2D

@onready var timer_display: Label = get_tree().current_scene.get_node('HUD/Screen/Header/Timer')

var timer: float = 0
var minutes: float = 0
var seconds: float = 0
var millis: String = '0'


func _ready():
	pass # Replace with function body.


func _process(delta):
	increment_timer(delta)


func increment_timer(delta: float):
	if Globals.player.is_dead:
		return
	
	timer += delta
	
	minutes = floor(timer / 60)
	seconds = floor(timer - minutes * 60)
	millis = str(timer).split('.')[1].substr(0, 4)
	
	timer_display.text = str(minutes) + ':' + str(seconds) + '.' + millis
