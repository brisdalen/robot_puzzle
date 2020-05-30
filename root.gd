extends Node2D

var player
var container
var old_pos
var player_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("player")
	player_animator = player.get_child(1)
	player_animator.connect("animation_finished", self, "on_anim_finished")
	player_animator.connect("animation_started", self, "on_anim_started")
	container = get_node("dead_player_container")

func on_anim_started(anim_name):
	if(anim_name == "die"):
		old_pos = player.position
		print(old_pos)

func on_anim_finished(anim_name):
	if(anim_name == "die"):
		print(old_pos)
		container.add_new_dead_child(old_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("keyboard_d") && player.get_state() != player.STATE.dying:
		player.die()