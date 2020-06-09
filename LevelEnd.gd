extends Area2D

signal level_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_player_body_entered")

func on_player_body_entered(body):
	if("player" in str(body.get_path())):
		# Scene change
		emit_signal("level_completed")
		
func change_scene_to(scene_path):
	get_tree().change_scene(scene_path)
	
