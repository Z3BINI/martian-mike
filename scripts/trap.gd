extends Node2D

signal touched_player

func _on_area_2d_body_entered(body):
	touched_player.emit()
