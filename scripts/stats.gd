extends Node

export var MAX_HEALTH = 100

onready var health = MAX_HEALTH

signal noHealth

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("noHealth")
