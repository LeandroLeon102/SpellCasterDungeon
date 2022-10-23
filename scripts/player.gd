extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP

export var max_health = 100
export var max_speed = Vector2(0, 0)
export var gravity = 10
export var acc = 20
export var friction = 5
export var max_jumps = 2
export var jump_speed = 200

onready var weapon_point = $WeaponPoint

var health = max_health
var vel = Vector2()
var jumps = max_jumps
var screensize = Vector2()
var snap_normal = Vector2.DOWN setget set_snap_normal

func _ready():
	screensize = get_viewport_rect().size
	

func jump():
	vel.y = 0
	vel.y += -jump_speed
	jumps += -1

func state_machine_update():
	pass

func _physics_process(_delta):
	var moving = false
	

	if is_on_floor():
		if vel.y > 100:
			print('damage')
		jumps = max_jumps
		vel.y = 0
	var input = Vector2.ZERO

	if Input.is_action_just_pressed("jump"):
		if jumps > 0:
			jump() 

	if Input.is_action_pressed("ui_right"):

		vel.x += acc
		moving = true 
	if Input.is_action_pressed("ui_left"):
		vel.x += -acc
		moving = true

		

	if not moving:
		if vel.x > 0:
			vel.x += -friction
		if vel.x < 0:
			vel.x += friction
			
			
	if not is_on_floor():
		if $Sprite.flip_h:
			$AnimationPlayer.play("air left")
		else: 
			$AnimationPlayer.play("air right")
		vel.y += gravity
	else:
		if vel.x > 0:

			$AnimationPlayer.play("run right")

		if vel.x < 0:

			$AnimationPlayer.play("run left")

		if vel.x == 0:
			if $Sprite.flip_h:
				$AnimationPlayer.play("idle left")
			else:
				$AnimationPlayer.play("idle right")


			

			
	
	# clamp x vel to max and min velocity
	vel.x = clamp(vel.x, -max_speed.x, max_speed.x)
	# clamp y vel to max and min velocity
	vel.y = clamp(vel.y, -max_speed.y, max_speed.y)
	
	if position.y > screensize.y:
		position.y = 0
	if position.x > screensize.x:
		position.x = 0
	if position.x < 0:
		position.x = screensize.x
		
	if vel.x > 0:
		$Sprite.flip_h = false
		$Sprite/eyes.position.x = 0
	if vel.x < 0:
		$Sprite.flip_h = true 
		$Sprite/eyes.position.x = -2
	var to_height = false
	
	vel = move_and_slide_with_snap(vel, snap_normal * 3, FLOOR_NORMAL, true)
	if vel.y > 400 :

		to_height = true
		if to_height and $RayCast2D.is_colliding():
			vel.y = 0
			get_damage(10)
func set_snap_normal(new_snap_normal):
	snap_normal = new_snap_normal
	
func get_damage(amount):
	health -= amount

