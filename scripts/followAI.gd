extends KinematicBody2D


export var GRAVITY = 700
export var ACCELERATION = 300
export var FRICTION = 0.25
export var AIR_RESISTANCE = 0.02
export var JUMP_FORCE = 300
export var MAX_SPEED = 100

onready var sprite = $Sprite
onready var PlayerDetectionArea = $PlayerDetectionArea
onready var Hurtbox = $HurtBox
onready var HitBox = $HitBox
onready var Stats = $stats


enum {
	IDLE,
	WANDER,
	CHASE
}




var motion = Vector2()
var player = null

var state = IDLE


func _ready():
	pass
	
func _physics_process(delta):
	
	if PlayerDetectionArea.can_see_player():
		state = CHASE

	match state:
		IDLE:
			motion = lerp(motion, Vector2.ZERO, AIR_RESISTANCE)
		WANDER:
			pass
		CHASE:
			player = PlayerDetectionArea.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
			else:
				state = IDLE
	
		
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
	motion = move_and_slide(motion, Vector2.UP)
	sprite.flip_h =   motion.x > 0

	

func take_damage(amount):
	Stats.set_health(Stats.health - amount)
	Hurtbox.start_invincibility()



func _on_HurtBox_area_entered(area):
	var area_parent = area.get_parent()
	if area_parent.is_in_group('player'):
		area_parent.take_damage(HitBox.damage)
		


func _on_stats_noHealth():
	queue_free()
