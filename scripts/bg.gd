extends ParallaxBackground

@export var scroll_speed = 25
@export var bg_texture : CompressedTexture2D = preload('res://assets/textures/bg/Blue.png')

@onready var sprite = $ParallaxLayer/Sprite2D

func _ready():
	sprite.texture = bg_texture

func _process(delta):
	sprite.region_rect.position += Vector2(-scroll_speed, scroll_speed) * delta
	
	if sprite.region_rect.position.x <= -64 && sprite.region_rect.position.y >= 64:
		sprite.region_rect.position = Vector2.ZERO
	
