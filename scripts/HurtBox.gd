extends Area2D

signal invincibility_started
signal invincibility_ended

var invincible = false setget set_invincible

onready var timer = $Timer


export(float) var invinsibility_time = 0.0

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")

	else:
		emit_signal("invincibility_ended")

	
func start_invincibility():
	set_invincible(true)
	timer.start(invinsibility_time)

	

func _on_Timer_timeout():
	set_invincible(false)


func _on_HurtBox_invincibility_started():
	set_deferred('monitoring', false)



func _on_HurtBox_invincibility_ended():
	set_deferred('monitoring', true)

