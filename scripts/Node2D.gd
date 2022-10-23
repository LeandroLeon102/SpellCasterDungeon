extends Node2D

onready var gem = $Gem
onready var gem_position = $gemPosition


func _ready():
	pass

func seek(target):
	pass
func _process(delta):
	var dir = ($Node2D/gemPosition.position - gem.position).normalized()
	gem.velocity = gem.velocity.move_toward(dir * ($Node2D/gemPosition.position - gem.position).length(), 100 * delta)
	gem.position += gem.velocity * delta
