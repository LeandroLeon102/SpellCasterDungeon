extends KinematicBody2D


const GRAVITY = 700
const ACCELERATION = 400
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const JUMP_FORCE = 300
const MAX_SPEED = 40

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()
var direction = 1

func _ready():
	pass


func _process(delta):
	if not $leftRayCast.is_colliding() or not $rightRayCast.is_colliding() or is_on_wall():
		direction *= -1
		
	motion.x += direction * ACCELERATION
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		

	motion.y += GRAVITY * delta
	motion = move_and_slide(motion, Vector2.UP)
