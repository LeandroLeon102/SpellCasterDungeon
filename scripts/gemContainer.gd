extends Node2D
onready var staff = get_node("../Staff")
onready var gem = $Gem

func _ready():
	pass
func _process(delta):
	var dir = (staff.get_node("gemPosition").position - gem.position).normalized()
	gem.velocity = gem.velocity.move_toward(dir * (staff.get_node("gemPosition").position - gem.position).length(), 100 * delta)
	gem.position += gem.velocity * delta
	

