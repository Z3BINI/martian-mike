extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var GRAVITY = 400
var SPEED = 150
var JUMP_FORCE = 225
var active = true

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y == 500:
			velocity.y = 500
	
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed('jump') && is_on_floor():
			jump(JUMP_FORCE)
			
		direction = Input.get_axis('left', 'right')
		
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	velocity.x = direction * SPEED
	
	move_and_slide()
	
	update_animations(direction)
	
func jump(force):
	velocity.y = -force
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play('idle')
		else:
			animated_sprite.play('run')
	else:
		if velocity.y < 0:
			animated_sprite.play('jump')
		else:
			animated_sprite.play('fall')
		
