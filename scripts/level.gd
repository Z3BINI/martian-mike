extends Node2D

@onready var start = $Start
@onready var exit = $Exit

var player = null

func _ready():
	exit.connect('body_entered', _on_body_entered)
	player = get_tree().get_first_node_in_group('player')
	if player != null:
		player.position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group('traps')
	for trap in traps:
		trap.connect('touched_player', _on_trap_touched_player)

func _process(delta):
	if Input.is_action_pressed('quit'):
		get_tree().quit()
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	player.velocity = Vector2.ZERO
	body.position = start.get_spawn_pos()

func _on_trap_touched_player():
	player.velocity = Vector2.ZERO
	player.position = start.get_spawn_pos()
	
func _on_body_entered(body):
	body.active = false
	exit.animate()
