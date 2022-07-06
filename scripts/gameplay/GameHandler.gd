extends Node2D

@onready var hud: CanvasLayer = get_tree().current_scene.get_node('HUD')
@onready var header: HBoxContainer = hud.get_node('Header')
@onready var timer_display: Label = hud.get_node('Timer/Label')
@onready var kill_counter: Label = header.get_node('KillCounter/HBox/Label')

var timer: float = 0
var minutes: float = 0
var seconds: float = 0
var millis: String = '0'
var enemies_killed = 0


func _process(delta):
	increment_timer(delta)
	kill_counter.text = str(enemies_killed)


func increment_enemies_killed():
	enemies_killed += 1


func increment_timer(delta: float):
	if Globals.player.is_dead:
		return
	
	timer += delta
	
	minutes = floor(timer / 60)
	seconds = floor(timer - minutes * 60)
	millis = str(timer).pad_decimals(4).split('.')[1].substr(0, 4)
	
	timer_display.text = str(minutes).pad_zeros(2) + ':' + str(seconds).pad_zeros(2) + '.' + millis
