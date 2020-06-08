extends KinematicBody2D

const GRAVITY = 500.0
const DOWNWARD_FORCE = 8.2
var spawn_location = Vector2()
var gravity_modifier = 1.0
var jumping = false
var jump_power = -385.0
var walk_speed = 215.0
var velocity = Vector2()
var anim_state = null
var moving = false
var wait_amount = 0.0
var direction = DIRECTION.right

onready var camera = get_node("Camera2D")
const DEFAULT_SMOOTHING_SPEED = 10.0
onready var anim_player = get_node("AnimationPlayer")

signal position_reset_finished(old_pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_state = STATE.idle
	spawn_location = self.global_position
	anim_player.connect("animation_finished", self, "on_animation_finished")
	
func on_animation_finished(anim_name):
	if(anim_state == STATE.dying):
		reset_position()
	
enum DIRECTION {
	left,
	right
}

enum STATE {
	moving,
	idle,
	sitting,
	dying
}

func get_state():
	return anim_state
	
func _process(delta):
	if anim_state != STATE.dying:
		if Input.is_action_pressed("ui_right"):
			anim_player.play("walking_right")
			direction = DIRECTION.right
			anim_state = STATE.moving
		elif Input.is_action_pressed("ui_left"):
			anim_player.play("walking_left")
			direction = DIRECTION.left
			anim_state = STATE.moving
		else:
			if wait_amount > 5.0:
				anim_state = STATE.sitting
				if direction == DIRECTION.right:
					anim_player.play("sitting_right")
				else:
					anim_player.play("sitting_left")
			else:
				if anim_state == STATE.idle:
					if direction == DIRECTION.right:
						anim_player.play("idle_right")
					else:
						anim_player.play("idle_left")
	
func get_input():
	velocity.x = 0
	if anim_state != STATE.dying:
		var left = Input.is_action_pressed("ui_left")
		var right = Input.is_action_pressed("ui_right")
		var jump = Input.is_action_just_pressed("ui_spacebar")
			
		if jump and is_on_floor():
			jumping = true
			velocity.y = jump_power
			moving = true
		if right:
			velocity.x += walk_speed
			moving = true
		if left:
			velocity.x -= walk_speed
			moving = true
			
		if moving:
			wait_amount = 0.0
			
		if !left && !right && !jumping && anim_state:
			moving = false
			anim_state = STATE.idle

func _physics_process(delta):
	get_input()
	velocity.y = velocity.y + DOWNWARD_FORCE + delta * GRAVITY * gravity_modifier
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if anim_state == STATE.idle:
		wait_amount += delta
	
func die():
	print("die() called")
	camera.smoothing_speed = 2
	anim_state = STATE.dying
	wait_amount = 0
	anim_player.play("die")
	
func reset_position():
	print("reset_position() called")
	anim_state = STATE.idle
	var old_pos = self.global_position
	position = spawn_location + Vector2(0, -70)
	velocity = Vector2(0,0)
	camera.smoothing_speed = DEFAULT_SMOOTHING_SPEED
	emit_signal("position_reset_finished", old_pos)