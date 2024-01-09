extends Node

var hurt = preload('res://assets/audio/hurt.wav')
var jump = preload('res://assets/audio/jump.wav')

func play_sfx(sfx_name : String):
	
	var stream = null
	if sfx_name == 'jump':
		stream = jump
	elif sfx_name == 'hurt':
		stream = hurt
	else:
		return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
