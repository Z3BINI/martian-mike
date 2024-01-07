extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var GRAVITY = 400
var SPEED = 150

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
	var direction = Input.get_axis('left', 'right')
	
	velocity.x = direction * SPEED
	
	move_and_slide()
