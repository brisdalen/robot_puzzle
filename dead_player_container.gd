extends Node2D

const DEAD_PLAYER = preload("res://dead_player.tscn")
const PLACEHOLDER = preload("res://placeholder.tscn")

func add_new_dead_child(position):
	# I think the player collides with the new dead object
	print("position passed - ", position)
	var new = DEAD_PLAYER.instance()
	add_child(new)
	new.global_position = position
	# add_placeholder(position)
	
func add_placeholder(position):
	print("position passed - ", position)
	var new = PLACEHOLDER.instance()
	new.set_position(position)
	add_child(new)