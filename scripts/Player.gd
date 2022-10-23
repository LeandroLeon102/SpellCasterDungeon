extends KinematicBody2D

signal set_health
signal shoot

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationMode = animationTree.get('parameters/playback')
onready var InvulnerabilityTimer = $InvulnerabilityTimer
onready var Stats = $stats
onready var Weapon = $Weapon
onready var jumpSound = $sounds/JumpSound
onready var footstepsSounds = $sounds/footsteps
onready var footPrints = $footprints
onready var downRayCast = $DownRayCast
onready var hurtBox = $HurtBox


export var GRAVITY = 700
export var ACCELERATION = 512
export var FRICTION = 0.25
export var AIR_RESISTANCE = 0.02
export var JUMP_FORCE = 300
export var MAX_SPEED = 128

var fall_dmg = [false, 0]
var motion = Vector2()
var spriteFlipH = false
var dashing = false
var x_input


func _ready():
	sprite.frame = 0

func _process(delta):
	x_input = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	if x_input != 0:
		
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		animationMode.travel('run')
				
	else:
		animationMode.travel('idle')
	if not is_on_wall() and x_input != 0 or motion.y != 0:

		footPrints.emitting = true
	else:
		footPrints.emitting = false
	if Input.is_action_just_pressed("ui_down"):
		position.y += 1
	if Input.is_action_just_pressed("shoot"):
		emit_signal('shoot')
		
	if  motion.y > 0 and not is_on_floor():
		animationMode.travel('falling')
			
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)

		if Input.is_action_pressed("jump"):
			jump()

	if is_on_wall() and not is_on_floor():
		if motion.y > 0:
			if x_input != 0:
				motion.y += -motion.y/5
		if Input.is_action_just_pressed("jump"):
			jump()
			motion.x = JUMP_FORCE * -x_input

	else:
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
		if motion.x < 0:
			spriteFlipH = true
		if motion.x > 0:
			spriteFlipH = false
	if Input.is_action_just_released("jump"):
		if motion.y <= -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2

	sprite.flip_h = spriteFlipH
	motion.y += GRAVITY * delta

	if motion.y > 480:
		fall_dmg = [true,motion.y]
		
	if downRayCast.is_colliding() and fall_dmg[0]:
		take_damage(int((fall_dmg[1] - 480)* .1))
		fall_dmg[0] = false


	motion = Vector2(int(motion.x),int(motion.y))
	motion = move_and_slide(motion, Vector2.UP)

func take_damage(amount):
	Stats.set_health(Stats.health - amount)
	emit_signal('set_health', Stats.health)
	hurtBox.start_invincibility()

func _on_stats_noHealth():
	queue_free()

func jump():
	var pitch_scale_random = rand_range(0.95, 1.05)
	jumpSound.pitch_scale = pitch_scale_random
	jumpSound.play()
	animationMode.travel('jump')
	motion.y = -JUMP_FORCE 





