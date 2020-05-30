extends KinematicBody2D

const GRAVITY = 500.0
const DOWNWARD_FORCE = 8.2
var gravity_modifier = 1.0
var velocity = Vector2()

func _physics_process(delta):
	velocity.y = velocity.y + DOWNWARD_FORCE + delta * GRAVITY * gravity_modifier
	velocity = move_and_slide(velocity, Vector2(0, -1))