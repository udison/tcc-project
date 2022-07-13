extends Control
class_name GameOver


@onready var http: HTTPRequest = $HTTPRequest
@onready var Globals: Globals = get_tree().get_root().get_node('Globals')
@onready var game_handler = get_tree().current_scene
@onready var Firebase: Firebase = get_tree().get_root().get_node('Firebase')

func _ready():
	Globals.game_over = self
	visible = false


func show():
	visible = true


func retry():
	get_tree().reload_current_scene()


func submit():
	var name = "Teste"
	var time = game_handler.timer
	var kills = game_handler.enemies_killed
	Firebase.submit_score(http, name, time, kills)


func on_submit_complete(result, response_code, headers, body):
	print("============= RESULT =============")
	print(result)
	print("=============  CODE  =============")
	print(response_code)
	print("=============  BODY  =============")
	print(body.get_string_from_utf8())
