extends KinematicBody2D

const GRAVITY = 500.0
const DOWNWARD_FORCE = 8.2
var gravity_modifier = 1.0
var velocity = Vector2()

var timer = null
var disabled_delay = 0.01

func _ready():
	print("dead player ready()")
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(disabled_delay)
	timer.connect("timeout", self, "on_timeout_completed")
	add_child(timer)
	$CollisionShape2D.disabled = true
	print("collision deactivated")
	timer.start()

func _physics_process(delta):
	velocity.y = velocity.y + DOWNWARD_FORCE + delta * GRAVITY * gravity_modifier
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func on_timeout_completed():
	$CollisionShape2D.disabled = false
	print("collision reactivated")