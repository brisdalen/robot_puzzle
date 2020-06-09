extends Node2D

var player
var container
var player_animator
var level_end
# Can this be streamlined?
onready var next_level = load("res://levels/level_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Engine.set_time_scale(0.05)
	player = get_node("player")
	player.connect("position_reset_finished", self, "on_position_reset_finished")
	player_animator = player.get_child(1)
	player_animator.connect("animation_started", self, "on_anim_started")
	container = get_node("dead_player_container")
	level_end = get_node("LevelEnd")
	level_end.connect("level_completed", self, "on_level_completed")
	#print("level end connected")

func on_anim_started(anim_name):
	if(anim_name == "die"):
		print("old pos - ", player.global_position)
		# container.add_placeholder(player.global_position)

func on_position_reset_finished(old_pos):
	print("position reset")
	container.add_new_dead_child(old_pos)

func on_level_completed():
	print("complete!")
	level_end.change_scene_to(next_level.get_path())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("keyboard_d") && player.get_state() != player.STATE.dying:
		player.die()