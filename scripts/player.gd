extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var GRAVITY = 400
var SPEED = 150
var JUMP_FORCE = 200

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y == 500:
			velocity.y = 500
	
	if Input.is_action_just_pressed('jump'):
		velocity.y = -JUMP_FORCE
		
	var direction = Input.get_axis('left', 'right')
	
	velocity.x = direction * SPEED
	
	move_and_slide()
