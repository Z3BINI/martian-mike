extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var JUMP_FORCE = 300

func _on_body_entered(body):
	animated_sprite.play('jump')
	body.jump(JUMP_FORCE)
