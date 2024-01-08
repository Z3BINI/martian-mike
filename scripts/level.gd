extends Node2D

@onready var start_pos = $StartPosition
@onready var player = $Player

func _process(delta):
	if Input.is_action_pressed('quit'):
		get_tree().quit()
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	player.velocity = Vector2.ZERO
	body.position = start_pos.position

func _on_trap_touched_player():
	player.velocity = Vector2.ZERO
	player.position = start_pos.position
