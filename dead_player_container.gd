extends Node2D

const DEAD_PLAYER = preload("res://dead_player.tscn")

func add_new_dead_child(position):
	var new = DEAD_PLAYER.instance()
	new.set_position(position)
	add_child(new)