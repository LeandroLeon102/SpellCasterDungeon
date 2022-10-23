extends Node2D

onready var life = $life

onready var frame = $frame



func _ready():
	pass
	
func set_health(health):
	
	life.scale.x = float(float(health) / float(100))
