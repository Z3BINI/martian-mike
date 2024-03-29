extends Node2D

@export var is_final_level = false
@export var next_level : PackedScene = null 
@export var level_time = 5

@onready var start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone
@onready var hud = $UI/HUD
@onready var ui = $UI

var player = null
var timer_node = null
var win = false
var time_left = null

func _ready():
	exit.connect('body_entered', _on_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	player = get_tree().get_first_node_in_group('player')
	if player != null:
		player.position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group('traps')
	for trap in traps:
		trap.connect('touched_player', _on_trap_touched_player)
	
	level_timer_setup()	
	
func level_timer_setup():
	time_left = level_time
	hud.set_time_label(time_left)
	timer_node = Timer.new()
	timer_node.name = 'LevelTimer'
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			AudioPlayer.play_sfx('hurt')
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)
		

func _process(delta):
	if Input.is_action_pressed('quit'):
		get_tree().quit()
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()

func reset_player():
	player.velocity = Vector2.ZERO
	player.position = start.get_spawn_pos()

func _on_deathzone_body_entered(body):
	AudioPlayer.play_sfx('hurt')
	reset_player()

func _on_trap_touched_player():
	AudioPlayer.play_sfx('hurt')
	reset_player()
	
func _on_body_entered(body):
	win = true
	body.active = false
	exit.animate()
	await get_tree().create_timer(1.5).timeout
	
	if next_level != null && is_final_level != true:
		get_tree().change_scene_to_packed(next_level)
	else:
		ui.show_win_screen(true)
