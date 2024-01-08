extends Node2D

@onready var start_pos = $StartPosition

func _process(delta):
	if Input.is_action_pressed('quit'):
		get_tree().quit()
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	body.position = start_pos.position
