extends Node2D

var player
var container
var player_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	# Engine.set_time_scale(0.05)
	player = get_node("player")
	player.connect("position_reset_finished", self, "on_position_reset_finished")
	player_animator = player.get_child(1)
	player_animator.connect("animation_finished", self, "on_anim_finished")
	player_animator.connect("animation_started", self, "on_anim_started")
	container = get_node("dead_player_container")

func on_anim_started(anim_name):
	if(anim_name == "die"):
		print("old pos - ", player.global_position)
		container.add_placeholder(player.global_position)

func on_position_reset_finished(old_pos):
	print("position reset")
	container.add_new_dead_child(old_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("keyboard_d") && player.get_state() != player.STATE.dying:
		player.die()